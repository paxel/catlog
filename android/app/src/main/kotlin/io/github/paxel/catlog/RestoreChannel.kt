package io.github.paxel.catlog

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.DocumentsContract
import androidx.documentfile.provider.DocumentFile
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

/// The backups of the install before this one live in Documents/catlog
/// (Downloads/catlog up to 1.2.2), written through MediaStore, which the
/// system keeps across an uninstall. A fresh install owns none of those rows and may not list
/// or read them — only the folder picker can grant them, once. This
/// channel opens the picker on that folder, then copies every .catsync
/// it holds into the cache and hands the paths to Dart.
class RestoreChannel(private val activity: Activity) {
    private var pending: MethodChannel.Result? = null

    companion object {
        const val PICK = 4712
        private const val DOCUMENTS_CATLOG =
            "content://com.android.externalstorage.documents/document/primary%3ADocuments%2Fcatlog"
    }

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "pickFolder" -> {
                    if (pending != null) {
                        result.success(null)
                        return
                    }
                    pending = result
                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            putExtra(DocumentsContract.EXTRA_INITIAL_URI, Uri.parse(DOCUMENTS_CATLOG))
                        }
                    }
                    activity.startActivityForResult(intent, PICK)
                }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("restore", e.message ?: e.toString(), null)
        }
    }

    /// The picker's answer: the .catsync files of the chosen folder,
    /// copied into the cache; null when the picker was dismissed.
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != PICK) return false
        val result = pending ?: return true
        pending = null
        val uri = if (resultCode == Activity.RESULT_OK) data?.data else null
        if (uri == null) {
            result.success(null)
            return true
        }
        try {
            // The folder itself, or the catlog-backups the Backups page
            // writes into when the keeper picked its parent.
            val picked = DocumentFile.fromTreeUri(activity, uri)
            val inside = picked?.findFile("catlog-backups")
            val tree = if (inside != null && inside.isDirectory) inside else picked
            val out = File(activity.cacheDir, "restore").apply {
                deleteRecursively()
                mkdirs()
            }
            val paths = mutableListOf<String>()
            for (doc in tree?.listFiles() ?: emptyArray()) {
                val name = doc.name ?: continue
                if (!doc.isFile || !name.contains(".catsync")) continue
                val target = File(out, name)
                activity.contentResolver.openInputStream(doc.uri)!!.use { input ->
                    target.outputStream().use { input.copyTo(it) }
                }
                target.setLastModified(doc.lastModified())
                paths.add(target.absolutePath)
            }
            result.success(paths)
        } catch (e: Exception) {
            result.error("restore", e.message ?: e.toString(), null)
        }
        return true
    }
}
