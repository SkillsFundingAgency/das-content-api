/*
	Insert or Update each of the [Application] values.

	NOTES:

	1) This script uses a temporary table, insert or update the values in the temporary table to apply changes; removed values will
	not take affect (by design); values which are removed should also be written into the DeleteApplication.sql script to remove
	manually any dependencies, but they must also be removed from the temporary table.
*/
CREATE TABLE #Application(
	[Id] BIGINT NOT NULL, 
    [Description] VARCHAR(100) NULL, 
    [Identity] VARCHAR(50) NOT NULL
) 

INSERT #Application VALUES (1, 'Employer Apprenticeship Service', 'das-employeraccounts-web')
INSERT #Application VALUES (2, 'Employer Apprenticeship Service (Legacy)', 'das-employeraccounts-web-legacy')
INSERT #Application VALUES (3, 'Provider Apprenticeship Service', 'das-providerapprenticeshipsservice-web')
INSERT #Application VALUES (4, 'Provider Apprenticeship Service (Legacy)', 'das-providerapprenticeshipsservice-web-legacy')
INSERT #Application VALUES (5, 'Employer Apprenticeship Service - Levy', 'das-employeraccounts-web-levy')
INSERT #Application VALUES (6, 'Employer Apprenticeship Service - Levy (Legacy)', 'das-employeraccounts-web-levy-legacy')
INSERT #Application VALUES (7, 'Employer Apprenticeship Service - NonLevy', 'das-employeraccounts-web-nonlevy')
INSERT #Application VALUES (8, 'Employer Apprenticeship Service - NonLevy (Legacy)', 'das-employeraccounts-web-nonlevy-legacy')

SET IDENTITY_INSERT [dbo].[Application] ON 

MERGE [Application] [Target] USING #Application [Source]
ON ([Source].Id = [Target].Id)
WHEN MATCHED
    THEN UPDATE SET 
        [Target].[Description] = [Source].[Description],
        [Target].[Identity] = [Source].[Identity]

WHEN NOT MATCHED BY TARGET 
    THEN INSERT ([Id], [Description], [Identity])
         VALUES ([Source].[Id], [Source].[Description], [Source].[Identity]);

SET IDENTITY_INSERT [dbo].[Application] OFF
