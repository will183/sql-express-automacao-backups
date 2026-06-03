# sql-express-automacao-backups
Rotina automatizada de backup FULL diário e LOG de transações a cada 5 minutos para SQL Server Express usando o Agendador de Tarefas do Windows


# Automação de Backups  para bases (ERP's) SQL Server Express

## Problematica encontrada 
Em cenários de ERPs de grande volume rodando sobre o SQL Server Express, a estratégia comum de realizar apenas um backup FULL diário é altamente falha. Caso ocorra um desastre ou travamento no meio do dia (ex: às 10:00 da manhã), todos os dados gerados desde o último backup (como vendas, notas fiscais e cadastros) são perdidos. Isso representa um RPO (Recovery Point Objective) inaceitável para o negócio.

Como o SQL Server Express **não possui o serviço SQL Server Agent**, a automação de rotinas de manutenção torna-se um desafio técnico.

## 💡 Caminho para solução
Este projeto implementa uma política de backup robusta com **RPO de 5 minutos**, garantindo que, em caso de falha catastrófica, a perda máxima de dados seja de apenas 5 minutos de operação.

A solução consiste em:
1. Alteração do modelo de recuperação do banco de dados para **FULL**.
2. Criação de scripts T-SQL para geração de backups **FULL diários** e backups de **LOG a cada 5 minutos**.
3. Uso do utilitário `sqlcmd` envelopado em arquivos de lote (`.bat`).
4. Orquestração e agendamento de tarefas através do **Agendador de Tarefas do Windows Server**.
5. Script automatizado de limpeza (`forfiles`) para gerenciar o espaço em disco e evitar retenção desnecessária.

 Estrutura do Projeto
* `/scripts/backup_full.sql`: Script T-SQL que gera o backup completo.
* `/scripts/backup_log.sql`: Script T-SQL que gera o backup do log de transações com carimbo de data/hora dinâmico.
* `/scripts/executa_full.bat` e `executa_log.bat`: Arquivos de lote que disparam o `sqlcmd`.
* `/scripts/limpa_logs.bat`: Script de manutenção que deleta logs com mais de 2 dias e backups full com mais de 5 dias.

## passo a passo 
1. Crie a estrutura de pastas no servidor (`C:\SQL_Automação\`, `C:\SQL_Backups\Full\`, `C:\SQL_Backups\Log\`).
2. Altere o Recovery Model do banco para FULL no SSMS.
3. Configure as duas tarefas no Agendador de Tarefas do Windows conforme detalhado na documentação técnica (marcar para rodar se o usuário estiver conectado ou não e com privilégios administrativos).
4. Configure a subfrequência da tarefa de LOG para repetir a cada 5 minutos por tempo indefinido.

## Tecnologias Utilizadas
* Transact-SQL (T-SQL)
* SQL Server Express Edition
* Windows CMD / Batch Scripts
* Windows Task Scheduler
