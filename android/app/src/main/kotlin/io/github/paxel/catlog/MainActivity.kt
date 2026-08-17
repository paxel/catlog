package io.github.paxel.catlog

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private var openChannel: MethodChannel? = null
    private var pendingOpen: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        openChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, "catlog/openfile")
        openChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "pending") {
                result.success(pendingOpen.also { pendingOpen = null })
            } else {
                result.notImplemented()
            }
        }
        intent?.let { handleViewIntent(it) }
        val hotspot = HotspotChannel(this)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/hotspot")
            .setMethodCallHandler { call, result -> hotspot.handle(call, result) }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/backup")
            .setMethodCallHandler { call, result ->
                if (call.method == "saveToDownloads") {
                    try {
                        val source = call.argument<String>("path")!!
                        val name = call.argument<String>("name")!!
                        result.success(saveToDownloads(File(source), name))
                    } catch (e: Exception) {
                        result.error("backup", e.message, null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleViewIntent(intent)
    }

    /// Copies a viewed .catsync (content: or file: URI) into the cache
    /// and hands the local path to Dart; queued until Dart asks when the
    /// app is cold-starting.
    private fun handleViewIntent(intent: Intent) {
        if (intent.action != Intent.ACTION_VIEW) return
        val uri: Uri = intent.data ?: return
        try {
            val target = File(cacheDir, "incoming.catsync")
            contentResolver.openInputStream(uri)!!.use { input ->
                target.outputStream().use { input.copyTo(it) }
            }
            pendingOpen = target.absolutePath
            openChannel?.invokeMethod("open", target.absolutePath)
        } catch (_: Exception) {
            // Unreadable share — the import screen stays reachable manually.
        }
    }

    /// Writes into MediaStore Downloads/catlog — system-owned storage
    /// that survives uninstalling the app. Replaces the previous backup.
    private fun saveToDownloads(source: File, name: String): String {
        val resolver = contentResolver
        val relativePath = Environment.DIRECTORY_DOWNLOADS + "/catlog"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Drop older copies of the same backup file. LIKE, not =:
            // earlier releases used a zip MIME type, and MediaStore renamed
            // those files to "$name.zip" (plus " (1)" duplicates).
            resolver.delete(
                MediaStore.Downloads.EXTERNAL_CONTENT_URI,
                "${MediaStore.MediaColumns.RELATIVE_PATH}=? AND ${MediaStore.MediaColumns.DISPLAY_NAME} LIKE ?",
                arrayOf("$relativePath/", "$name%")
            )
            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, name)
                // A recognized MIME type would make MediaStore force its
                // extension onto the file; octet-stream keeps ".catsync".
                put(MediaStore.MediaColumns.MIME_TYPE, "application/octet-stream")
                put(MediaStore.MediaColumns.RELATIVE_PATH, relativePath)
            }
            val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                ?: throw IllegalStateException("MediaStore insert failed")
            resolver.openOutputStream(uri)!!.use { out ->
                source.inputStream().use { it.copyTo(out) }
            }
            return uri.toString()
        } else {
            @Suppress("DEPRECATION")
            val dir = File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
                "catlog"
            )
            dir.mkdirs()
            val target = File(dir, name)
            source.copyTo(target, overwrite = true)
            return target.absolutePath
        }
    }
}
