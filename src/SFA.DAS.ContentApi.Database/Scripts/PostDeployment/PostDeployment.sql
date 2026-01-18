BEGIN TRANSACTION

:r .\DeleteApplicationContent.sql
:r .\DeleteApplication.sql
:r .\DeleteContent.sql
:r .\DeleteContentType.sql

:r .\InsertOrUpdateApplication.sql
:r .\InsertOrUpdateContentType.sql
:r .\InsertOrUpdateContent.sql
:r .\InsertOrUpdateApplicationContent.sql
:r .\EI_Closing_Banner_2025.sql
:r .\Forecasting_Decom_05_2025.sql
:r .\NAW_Maintenance_Combined_Banner_2026.sql
:r .\NAW_Banner_2026.sql

COMMIT TRANSACTION
