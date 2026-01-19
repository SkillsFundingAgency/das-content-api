/*
	Insert or Update each of the [ApplicationContent] values.

	NOTES:

	1) This script uses a temporary table, insert or update the values in the temporary table to apply changes; removed values will
	not take affect (by design); values which are removed should also be written into the DeleteApplicationContent.sql script to remove
	manually any dependencies, but they must also be removed from the temporary table.
*/
CREATE TABLE #ApplicationContent(
	[Id] BIGINT NOT NULL, 
    [ContentId] BIGINT NOT NULL, 
    [ApplicationId] BIGINT NOT NULL
) 

INSERT #ApplicationContent VALUES (1, 1, 1)
INSERT #ApplicationContent VALUES (2, 1, 2)
INSERT #ApplicationContent VALUES (3, 3, 3)
INSERT #ApplicationContent VALUES (4, 4, 4)
INSERT #ApplicationContent VALUES (5, 5, 1)
INSERT #ApplicationContent VALUES (6, 5, 2)
INSERT #ApplicationContent VALUES (7, 7, 3)
INSERT #ApplicationContent VALUES (8, 2, 1)
INSERT #ApplicationContent VALUES (9, 2, 2)

SET IDENTITY_INSERT [dbo].[ApplicationContent] ON 

MERGE [ApplicationContent] [Target] USING #ApplicationContent [Source]
ON ([Source].Id = [Target].Id)
WHEN MATCHED
    THEN UPDATE SET 
        [Target].[ContentId] = [Source].[ContentId],
		[Target].[ApplicationId] = [Source].[ApplicationId]

WHEN NOT MATCHED BY TARGET 
    THEN INSERT ([Id], [ContentId], [ApplicationId])
         VALUES ([Source].[Id], [Source].[ContentId], [Source].[ApplicationId]);

DELETE FROM [dbo].[ApplicationContent]
WHERE [Id] NOT IN (SELECT [Id] FROM #ApplicationContent);

-- Drop the temporary table
DROP TABLE #ApplicationContent;

SET IDENTITY_INSERT [dbo].[ApplicationContent] OFF
