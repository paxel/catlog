package io.github.paxel.catlog

import android.app.backup.BackupAgent
import android.app.backup.BackupDataInput
import android.app.backup.BackupDataOutput
import android.app.backup.FullBackupDataOutput
import android.os.ParcelFileDescriptor
import java.io.File
import java.time.Instant

/// Android's app backup to the keeper's Google account (Auto Backup):
/// the catalogs and settings go, the photos stay — the quota is 25 MB
/// per app and a catalog's pictures blow it, while the entries of a
/// catalog fit many times over. Photos come back from partners, from
/// the shared folder, or from the .catsync copies in Documents/catlog.
///
/// A custom agent because the rule files take literal paths only, and
/// the photo folders sit under per-catalog ids nobody knows in advance.
/// Android restores the files before the first launch; the app then
/// starts as it was. A marker file says that happened, for the Backups
/// page to name the date.
class CatlogBackupAgent : BackupAgent() {
    companion object {
        const val RESTORED_MARKER = "restored-from-backup"
    }

    override fun onBackup(
        oldState: ParcelFileDescriptor?,
        data: BackupDataOutput?,
        newState: ParcelFileDescriptor?
    ) {
        // Key-value backup is not used; full backup below is.
    }

    override fun onRestore(
        data: BackupDataInput?,
        appVersionCode: Int,
        newState: ParcelFileDescriptor?
    ) {
        // Key-value restore is not used.
    }

    override fun onFullBackup(data: FullBackupDataOutput) {
        walk(filesDir, data)
    }

    private fun walk(dir: File, data: FullBackupDataOutput) {
        for (f in dir.listFiles() ?: return) {
            when {
                f.isDirectory && f.name == "images" -> continue
                f.isDirectory -> walk(f, data)
                f.name == RESTORED_MARKER -> continue
                else -> fullBackupFile(f, data)
            }
        }
    }

    override fun onRestoreFinished() {
        try {
            File(filesDir, RESTORED_MARKER).writeText(Instant.now().toString())
        } catch (_: Exception) {
            // The marker is a courtesy line on a page, never worth a failure.
        }
    }
}
