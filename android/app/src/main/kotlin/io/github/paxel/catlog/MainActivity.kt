package io.github.paxel.catlog

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private var openChannel: MethodChannel? = null
    private var pendingOpen: String? = null
    private var pendingImages: List<String>? = null
    private var folderChannel: FolderChannel? = null
    private var restoreChannel: RestoreChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        openChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, "catlog/openfile")
        openChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "pending") {
                result.success(pendingOpen.also { pendingOpen = null })
            } else if (call.method == "pendingImages") {
                result.success(pendingImages.also { pendingImages = null })
            } else {
                result.notImplemented()
            }
        }
        intent?.let { handleViewIntent(it) }
        intent?.let { handleShareIntent(it) }
        val hotspot = HotspotChannel(this)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/hotspot")
            .setMethodCallHandler { call, result -> hotspot.handle(call, result) }
        // The shared sync folder through the picker's grant (1.2.2).
        val folder = FolderChannel(this).also { folderChannel = it }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/folder")
            .setMethodCallHandler { call, result -> folder.handle(call, result) }
        // The backups of the install before, through the picker (1.2.3).
        val restore = RestoreChannel(this).also { restoreChannel = it }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/restore")
            .setMethodCallHandler { call, result -> restore.handle(call, result) }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "catlog/backup")
            .setMethodCallHandler { call, result ->
                if (call.method == "saveToDocuments") {
                    try {
                        val source = call.argument<String>("path")!!
                        val name = call.argument<String>("name")!!
                        result.success(saveToDocuments(File(source), name))
                    } catch (e: Exception) {
                        result.error("backup", e.message, null)
                    }
                } else if (call.method == "deleteFromDocuments") {
                    try {
                        deleteFromDocuments(call.argument<String>("name")!!)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("backup", e.message, null)
                    }
                } else if (call.method == "openBatterySettings") {
                    // Where the maker's battery saver can be told to leave
                    // the app's reminders alone.
                    try {
                        startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
                        result.success(true)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleViewIntent(intent)
        handleShareIntent(intent)
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (folderChannel?.onActivityResult(requestCode, resultCode, data) == true) return
        if (restoreChannel?.onActivityResult(requestCode, resultCode, data) == true) return
        @Suppress("DEPRECATION")
        super.onActivityResult(requestCode, resultCode, data)
    }

    /// Copies a viewed .catsync (content: or file: URI) into the cache
    /// and hands the local path to Dart; queued until Dart asks when the
    /// app is cold-starting.
    private fun handleViewIntent(intent: Intent) {
        if (intent.action != Intent.ACTION_VIEW) return
        val uri: Uri = intent.data ?: return
        try {
            // Unique per intent: a second file must not overwrite one
            // the app is still about to read. The app deletes it after
            // the import.
            val target = File(cacheDir, "incoming-${System.currentTimeMillis()}.catsync")
            contentResolver.openInputStream(uri)!!.use { input ->
                target.outputStream().use { input.copyTo(it) }
            }
            pendingOpen = target.absolutePath
            openChannel?.invokeMethod("open", target.absolutePath)
        } catch (_: Exception) {
            // Unreadable share — the import screen stays reachable manually.
        }
    }

    /// Images and videos shared INTO the app (Immich, Signal, browser, …):
    /// copy each content URI into the cache and hand the paths to Dart,
    /// which asks the user which cat they belong to. Queued for cold
    /// starts.
    private fun handleShareIntent(intent: Intent) {
        val uris: List<Uri> = when (intent.action) {
            Intent.ACTION_SEND ->
                listOfNotNull(
                    @Suppress("DEPRECATION")
                    intent.getParcelableExtra(Intent.EXTRA_STREAM))
            Intent.ACTION_SEND_MULTIPLE ->
                @Suppress("DEPRECATION")
                intent.getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM)
                    ?: emptyList()
            else -> return
        }
        if (uris.isEmpty()) return
        val paths = mutableListOf<String>()
        for ((i, uri) in uris.withIndex()) {
            try {
                // A video keeps its kind in the name: Dart runs the frame
                // picker over it instead of treating it as one photo.
                val mime = contentResolver.getType(uri) ?: intent.type ?: ""
                val kind = if (mime.startsWith("video/")) "video" else "img"
                val target = File(cacheDir, "shared-${System.currentTimeMillis()}-$i.$kind")
                contentResolver.openInputStream(uri)!!.use { input ->
                    target.outputStream().use { input.copyTo(it) }
                }
                paths.add(target.absolutePath)
            } catch (_: Exception) {
                // Unreadable stream — skip it, keep the rest.
            }
        }
        if (paths.isEmpty()) return
        pendingImages = paths
        openChannel?.invokeMethod("sharedImages", paths)
    }

    /// Where the backups go on shared storage: Documents/catlog, through
    /// MediaStore, which keeps the rows across an uninstall. Releases up
    /// to 1.2.2 used Downloads/catlog; a delete covers both.
    private val backupPaths = listOf(
        Environment.DIRECTORY_DOCUMENTS + "/catlog",
        Environment.DIRECTORY_DOWNLOADS + "/catlog",
    )

    private val filesUri: Uri
        get() = MediaStore.Files.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)

    /// Removes this app's copies of a backup file, wherever a release put
    /// them — used when a catalog is renamed, so the folder does not fill
    /// with names that no longer mean anything. Rows another install
    /// wrote are not this app's to delete; those stay.
    private fun deleteFromDocuments(name: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            for (path in backupPaths) {
                contentResolver.delete(
                    filesUri,
                    "${MediaStore.MediaColumns.RELATIVE_PATH}=? AND ${MediaStore.MediaColumns.DISPLAY_NAME} LIKE ?",
                    arrayOf("$path/", "$name%")
                )
            }
        } else {
            @Suppress("DEPRECATION")
            for (dir in listOf(Environment.DIRECTORY_DOCUMENTS, Environment.DIRECTORY_DOWNLOADS)) {
                File(File(Environment.getExternalStoragePublicDirectory(dir), "catlog"), name).delete()
            }
        }
    }

    /// Writes into MediaStore Documents/catlog — system-owned storage
    /// that survives uninstalling the app. Replaces the previous backup.
    private fun saveToDocuments(source: File, name: String): String {
        val resolver = contentResolver
        val relativePath = backupPaths.first()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Drop older copies of the same backup file. LIKE, not =:
            // earlier releases used a zip MIME type, and MediaStore renamed
            // those files to "$name.zip" (plus " (1)" duplicates).
            deleteFromDocuments(name)
            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, name)
                // A recognized MIME type would make MediaStore force its
                // extension onto the file; octet-stream keeps ".catsync".
                put(MediaStore.MediaColumns.MIME_TYPE, "application/octet-stream")
                put(MediaStore.MediaColumns.RELATIVE_PATH, relativePath)
            }
            val uri = resolver.insert(filesUri, values)
                ?: throw IllegalStateException("MediaStore insert failed")
            resolver.openOutputStream(uri)!!.use { out ->
                source.inputStream().use { it.copyTo(out) }
            }
            return uri.toString()
        } else {
            @Suppress("DEPRECATION")
            val dir = File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOCUMENTS),
                "catlog"
            )
            dir.mkdirs()
            val target = File(dir, name)
            source.copyTo(target, overwrite = true)
            return target.absolutePath
        }
    }
}
