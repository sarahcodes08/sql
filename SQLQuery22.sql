-- With NORECOVERY (to apply more backups later)
RESTORE DATABASE LabBackupDemo1
FROM DISK = 'D:\Backup\LabBackupDemo1_Full.bak'
WITH NORECOVERY;

-- With RECOVERY (final step)
RESTORE LOG LabBackupDemo1
FROM DISK = 'D:\Backup\LabBackupDemo1_Log.trn'
WITH RECOVERY;