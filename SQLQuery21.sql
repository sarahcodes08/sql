-- Restore transaction log to a time before the error
RESTORE LOG LabBackupDemo1
FROM DISK = 'D:\Backup\LabBackupDemo1_Log.trn'
WITH STOPAT = '2025-05-25 23:38:56', RECOVERY;
GO