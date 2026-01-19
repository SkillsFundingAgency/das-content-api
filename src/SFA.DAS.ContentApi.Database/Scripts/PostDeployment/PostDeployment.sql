BEGIN TRANSACTION

:r .\DeleteApplicationContent.sql
:r .\DeleteApplication.sql
:r .\DeleteContent.sql
:r .\DeleteContentType.sql

:r .\InsertOrUpdateApplication.sql
:r .\InsertOrUpdateContentType.sql
:r .\InsertOrUpdateContent.sql
:r .\InsertOrUpdateApplicationContent.sql
:r .\NAW_Maintenance_Combined_Banner_2026.sql
:r .\NAW_Banner_2026.sql

COMMIT TRANSACTION
