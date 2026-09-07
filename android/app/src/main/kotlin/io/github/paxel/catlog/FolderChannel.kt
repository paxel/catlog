package io.github.paxel.catlog

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.documentfile.provider.DocumentFile
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/// The shared sync folder through the access the folder picker grants
/// (Storage Access Framework): a tree URI, persistable, good for the
/// storage root and for cloud providers alike — none of which is a
/// path an app may read on Android 11 and later. Dart sees the folder
/// as `catlog-sync` with `blobs` and `keys` inside, addressed by name.
class FolderChannel(private val activity: Activity) {
    private var pendingPick: MethodChannel.Result? = null

    companion object {
        const val PICK = 4711
        private const val ROOT = "catlog-sync"
    }

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "pickTree" -> {
                    if (pendingPick != null) {
                        result.success(null)
                        return
                    }
                    pendingPick = result
                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                        addFlags(
                            Intent.FLAG_GRANT_READ_URI_PERMISSION or
                                Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                                Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
                        )
                    }
                    activity.startActivityForResult(intent, PICK)
                }
                "name" -> result.success(tree(call)?.name)
                "list" -> {
                    val dir = dir(call, create = false)
                    result.success(
                        dir?.listFiles()?.filter { it.isFile }?.mapNotNull { it.name }
                            ?: emptyList<String>()
                    )
                }
                "read" -> {
                    val file = dir(call, create = false)?.findFile(name(call))
                    if (file == null || !file.isFile) {
                        result.success(null)
                    } else {
                        activity.contentResolver.openInputStream(file.uri)!!.use {
                            result.success(it.readBytes())
                        }
                    }
                }
                "write" -> {
                    val dir = dir(call, create = true)!!
                    val name = name(call)
                    // octet-stream keeps the name as given; a known type
                    // would make the provider force its extension on it.
                    val file = dir.findFile(name)
                        ?: dir.createFile("application/octet-stream", name)
                        ?: throw IllegalStateException("cannot create $name")
                    // "wt": truncate, so a shorter file leaves no old tail.
                    activity.contentResolver.openOutputStream(file.uri, "wt")!!.use {
                        it.write(call.argument<ByteArray>("bytes")!!)
                    }
                    result.success(null)
                }
                "delete" -> {
                    dir(call, create = false)?.findFile(name(call))?.delete()
                    result.success(null)
                }
                "ensure" -> {
                    dir(call, create = true)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("folder", e.message ?: e.toString(), null)
        }
    }

    /// The picker's answer: the tree URI, kept across restarts.
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != PICK) return false
        val pending = pendingPick ?: return true
        pendingPick = null
        val uri = if (resultCode == Activity.RESULT_OK) data?.data else null
        if (uri != null) {
            try {
                activity.contentResolver.takePersistableUriPermission(
                    uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                )
            } catch (_: Exception) {
                // Some providers grant nothing persistable; the URI still
                // works for this process.
            }
        }
        pending.success(uri?.toString())
        return true
    }

    private fun tree(call: MethodCall): DocumentFile? =
        DocumentFile.fromTreeUri(activity, Uri.parse(call.argument<String>("tree")!!))

    private fun name(call: MethodCall): String = call.argument<String>("name")!!

    /// `catlog-sync`, or a subfolder of it; made on the way when [create].
    private fun dir(call: MethodCall, create: Boolean): DocumentFile? {
        var dir = tree(call) ?: return null
        val sub = call.argument<String>("dir") ?: ""
        val path = if (sub.isEmpty()) listOf(ROOT) else listOf(ROOT, sub)
        for (segment in path) {
            val next = dir.findFile(segment)
            dir = when {
                next != null && next.isDirectory -> next
                create -> dir.createDirectory(segment)
                    ?: throw IllegalStateException("cannot create $segment")
                else -> return null
            }
        }
        return dir
    }
}
