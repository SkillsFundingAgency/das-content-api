/*
	Insert or Update each of the [ContentType] values.

	NOTES:

	1) This script uses a temporary table, insert or update the values in the temporary table to apply changes; removed values will
	not take affect (by design); values which are removed should also be written into the DeleteContentType.sql script to remove
	manually any dependencies, but they must also be removed from the temporary table.
*/
CREATE TABLE #ContentType(
	[Id] BIGINT NOT NULL, 
    [Value] VARCHAR(20) NOT NULL
) 

INSERT #ContentType VALUES (1, 'banner')
INSERT #ContentType VALUES (2, 'covid_section')

SET IDENTITY_INSERT [dbo].[ContentType] ON 

MERGE [ContentType] [Target] USING #ContentType [Source]
ON ([Source].Id = [Target].Id)
WHEN MATCHED
    THEN UPDATE SET 
        [Target].[Value] = [Source].[Value]

WHEN NOT MATCHED BY TARGET 
    THEN INSERT ([Id], [Value])
         VALUES ([Source].[Id], [Source].[Value]);

DELETE FROM [dbo].[ContentType]
WHERE [Id] NOT IN (SELECT [Id] FROM #ContentType);

-- Drop the temporary table
DROP TABLE #ContentType;

SET IDENTITY_INSERT [dbo].[ContentType] OFF
