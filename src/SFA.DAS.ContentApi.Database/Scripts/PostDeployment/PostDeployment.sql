BEGIN TRANSACTION

:r .\DeleteApplicationContent.sql
:r .\DeleteApplication.sql
:r .\DeleteContent.sql
:r .\DeleteContentType.sql

:r .\InsertOrUpdateApplication.sql
:r .\InsertOrUpdateContentType.sql
:r .\InsertOrUpdateContent.sql
:r .\InsertOrUpdateApplicationContent.sql
:r .\NAW_Banner_2025.sql

COMMIT TRANSACTION
