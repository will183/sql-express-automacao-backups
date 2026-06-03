USE master;
GO

DECLARE @DBName VARCHAR(100) = 'minha_base_sqlserverexpress'; -- Altere para o nome do banco do seu ERP
DECLARE @FileName VARCHAR(255);
DECLARE @DataHora VARCHAR(50);

-- Formata a data e hora para o nome do arquivo (Ex: ERP_LOG_2026_06_02_2230)
SET @DataHora = REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, GETDATE(), 120), '-', '_'), ':', ''), ' ', '_');
SET @FileName = 'C:\SQL_Backups\Log\LOG_' + @DBName + '_' + @DataHora + '.trn';

-- Executa o backup do Log de transações com compactação
BACKUP LOG [minha_base_sqlserverexpress] 
TO DISK = @FileName WITH COMPRESSION, STATS = 10;
GO
