@echo off
sqlcmd -S LOCALHOST\SQLEXPRESS -E -i "C:\SQL_Automação\backup_log.sql"
