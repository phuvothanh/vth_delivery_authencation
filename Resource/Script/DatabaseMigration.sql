IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200224170448_AddCompany')
BEGIN
    CREATE TABLE [Company] (
        [CompanyId] int NOT NULL IDENTITY,
        [CompanyName] nvarchar(100) NOT NULL,
        [Address] nvarchar(100) NULL,
        [Phone] nvarchar(20) NULL,
        [Fax] nvarchar(20) NULL,
        [Email] nvarchar(30) NULL,
        [TaxCode] nvarchar(20) NULL,
        [IsDisable] bit NOT NULL,
        [IsDeleted] bit NOT NULL,
        [IsGDPRRemoved] bit NOT NULL,
        CONSTRAINT [PK_Company] PRIMARY KEY ([CompanyId])
    );

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200224170448_AddCompany', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200425093200_AddAppSettings_PV')
BEGIN
	CREATE TABLE [AppSettings] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(30) NOT NULL,
    [Value] nvarchar(1000) NULL,
    CONSTRAINT [PK_AppSettings] PRIMARY KEY ([Id])
    );

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200425093200_AddAppSettings_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200521072713_AddUserFields_PV')
BEGIN
	DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'LastName');
    IF @var0 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
        ALTER TABLE [AspNetUsers] ALTER COLUMN [LastName] nvarchar(50) NULL;
    END

    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'FirstName');
    IF @var1 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var1 + '];');
        ALTER TABLE [AspNetUsers] ALTER COLUMN [FirstName] nvarchar(50) NOT NULL;
    END

    ALTER TABLE [AspNetUsers] ADD [Address] nvarchar(100) NULL;
    ALTER TABLE [AspNetUsers] ADD [ApplicationId] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [Avatar] nvarchar(200) NULL;
    ALTER TABLE [AspNetUsers] ADD [Barcode] nvarchar(50) NULL;
    ALTER TABLE [AspNetUsers] ADD [BirthDay] datetime2 NULL;
    ALTER TABLE [AspNetUsers] ADD [ChangeBy] int NULL;
    ALTER TABLE [AspNetUsers] ADD [ChangeOn] datetime2 NULL;
    ALTER TABLE [AspNetUsers] ADD [CreateBy] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [CreateOn] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
    ALTER TABLE [AspNetUsers] ADD [District] nvarchar(10) NULL;
    ALTER TABLE [AspNetUsers] ADD [Gender] nvarchar(1) NULL;
    ALTER TABLE [AspNetUsers] ADD [IDBack] nvarchar(100) NULL;
    ALTER TABLE [AspNetUsers] ADD [IDFront] nvarchar(100) NULL;
    ALTER TABLE [AspNetUsers] ADD [InActive] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [InActiveOn] datetime2 NULL;
    ALTER TABLE [AspNetUsers] ADD [IsChat] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [IsEmployee] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [IsVideo] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [LimitTime] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [National] nvarchar(5) NULL;
    ALTER TABLE [AspNetUsers] ADD [NotifyUnread] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [PersonalNumber] nvarchar(12) NULL;
    ALTER TABLE [AspNetUsers] ADD [Province] nvarchar(10) NULL;
    ALTER TABLE [AspNetUsers] ADD [Rating] real NOT NULL DEFAULT CAST(0 AS real);
    ALTER TABLE [AspNetUsers] ADD [TimeUsed] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [TotalTime] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [Ward] nvarchar(10) NULL;

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200521072713_AddUserFields_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200523105155_AddUserExternalLogin_PV')
BEGIN
	DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'Avatar');
    IF @var0 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
    END

	ALTER TABLE [AspNetUsers] ALTER COLUMN [Avatar] nvarchar(200) NULL;

    ALTER TABLE [AspNetUsers] ADD [FaceBookId] nvarchar(20) NULL;
    ALTER TABLE [AspNetUsers] ADD [IsFacebookUser] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [IsGoogleUser] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [IsZaloUser] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [ZaloId] nvarchar(20) NULL;

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200523105155_AddUserExternalLogin_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200523172458_UpdateUserPhoneNumberLimit_PV')
BEGIN
	DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'PhoneNumber');
    IF @var0 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
        ALTER TABLE [AspNetUsers] ALTER COLUMN [PhoneNumber] nvarchar(20) NULL;
    END

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200523172458_UpdateUserPhoneNumberLimit_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200526170642_AddUserContactAndProvince_PV')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'FirstName');
    IF @var0 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [FirstName];
    END

    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'LastName');
    IF @var1 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var1 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [LastName];
    END

    ALTER TABLE [AspNetUsers] ADD [FullName] nvarchar(50) NOT NULL DEFAULT N'';
    ALTER TABLE [AspNetUsers] ADD [IsGDPRRemoved] bit NOT NULL DEFAULT CAST(0 AS bit);
    ALTER TABLE [AspNetUsers] ADD [LatLong] nvarchar(25) NULL;
    ALTER TABLE [AspNetUsers] ADD [Specialist] nvarchar(100) NULL;
    ALTER TABLE [AspNetUsers] ADD [TotalLike] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [TotalShare] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [TotalView] int NOT NULL DEFAULT 0;
    ALTER TABLE [AspNetUsers] ADD [UserType] smallint NOT NULL DEFAULT CAST(0 AS smallint);

    CREATE TABLE [Contacts] (
        [Id] int NOT NULL IDENTITY,
        [FullName] nvarchar(50) NOT NULL,
        [BirthDay] datetime2 NULL,
        [PhoneNumber] nvarchar(20) NULL,
        [Gender] smallint NOT NULL,
        [PersonalNumber] nvarchar(12) NULL,
        [RelationShip] smallint NOT NULL,
        [Email] nvarchar(50) NULL,
        [Address] nvarchar(100) NULL,
        [Note] nvarchar(200) NULL,
        [History] nvarchar(500) NULL,
        [Pharmacys] nvarchar(1000) NULL,
        [Barcode] nvarchar(50) NULL,
        [CreateOn] datetime2 NOT NULL,
        [CreateBy] int NOT NULL,
        [ChangeOn] datetime2 NULL,
        [ChangeBy] int NULL,
        CONSTRAINT [PK_Contacts] PRIMARY KEY ([Id])
    );

    CREATE TABLE [Districts] (
        [Id] nvarchar(10) NOT NULL,
        [Name] nvarchar(50) NULL,
        [ProvinceId] nvarchar(10) NULL,
        CONSTRAINT [PK_Districts] PRIMARY KEY ([Id])
    );

    CREATE TABLE [Provinces] (
        [Id] nvarchar(10) NOT NULL,
        [Name] nvarchar(50) NULL,
        [Area] nvarchar(10) NULL,
        CONSTRAINT [PK_Provinces] PRIMARY KEY ([Id])
    );

    CREATE TABLE [UserActions] (
        [Id] int NOT NULL IDENTITY,
        [ClinicId] int NOT NULL,
        [ActionType] int NOT NULL,
        [ByUserId] int NOT NULL,
        [CreateOn] datetime2 NOT NULL,
        CONSTRAINT [PK_UserActions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_UserActions_AspNetUsers_ClinicId] FOREIGN KEY ([ClinicId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );

    CREATE TABLE [Wards] (
        [Id] nvarchar(10) NOT NULL,
        [Name] nvarchar(50) NULL,
        [DistrictId] nvarchar(10) NULL,
        [Code] nvarchar(10) NULL,
        CONSTRAINT [PK_Wards] PRIMARY KEY ([Id])
    );

    CREATE INDEX [IX_UserActions_ClinicId] ON [UserActions] ([ClinicId]);

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200526170642_AddUserContactAndProvince_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200604154450_AddIsBookingToUser_PV')
BEGIN
	ALTER TABLE [AspNetUsers] ADD [IsBooking] bit NOT NULL DEFAULT CAST(0 AS bit);

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200604154450_AddIsBookingToUser_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200605052701_AddDeviceTokens_PV')
BEGIN
	CREATE TABLE [DeviceTokens] (
    [Id] int NOT NULL IDENTITY,
    [UserId] int NOT NULL,
    [Token] nvarchar(300) NOT NULL,
    [IsActive] bit NOT NULL,
    [IsDeleted] bit NOT NULL,
    [LastUpdate] datetime2 NOT NULL,
    CONSTRAINT [PK_DeviceTokens] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_DeviceTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );

    CREATE INDEX [IX_DeviceTokens_UserId] ON [DeviceTokens] ([UserId]);

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200605052701_AddDeviceTokens_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200605100325_AddApplicationToDeviceToken_PV')
BEGIN
	ALTER TABLE [DeviceTokens] ADD [ApplicationId] int NOT NULL DEFAULT 0;

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200605100325_AddApplicationToDeviceToken_PV', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200606050140_RemoveSomePropertiesFromUser')
BEGIN
	DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'IsChat');
    
    IF @var0 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [IsChat];
    END

    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'IsVideo');
    
    IF @var1 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var1 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [IsVideo];
    END

    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'LimitTime');
    
    IF @var2 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var2 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [LimitTime];
    END

    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'TimeUsed');
    
    IF @var3 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var3 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [TimeUsed];
    END

    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'TotalTime');
    
    IF @var4 IS NOT NULL
    BEGIN
        EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var4 + '];');
        ALTER TABLE [AspNetUsers] DROP COLUMN [TotalTime];
    END

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200606050140_RemoveSomePropertiesFromUser', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200607044948_AddProvinceRelationship')
BEGIN
	CREATE INDEX [IX_AspNetUsers_District] ON [AspNetUsers] ([District]);
    CREATE INDEX [IX_AspNetUsers_Province] ON [AspNetUsers] ([Province]);
    CREATE INDEX [IX_AspNetUsers_Ward] ON [AspNetUsers] ([Ward]);
    ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Districts_District] FOREIGN KEY ([District]) REFERENCES [Districts] ([Id]) ON DELETE NO ACTION;
    ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Provinces_Province] FOREIGN KEY ([Province]) REFERENCES [Provinces] ([Id]) ON DELETE NO ACTION;
    ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Wards_Ward] FOREIGN KEY ([Ward]) REFERENCES [Wards] ([Id]) ON DELETE NO ACTION;

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200607044948_AddProvinceRelationship', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20200622080059_ChangeGenderDataType')
BEGIN

    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'Gender');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
    
    ALTER TABLE [AspNetUsers] ALTER COLUMN [Gender] smallint NOT NULL;

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20200622080059_ChangeGenderDataType', N'3.1.2');
END

GO

IF NOT EXISTS(SELECT 1 FROM __EFMigrationsHistory WHERE [MigrationId] = N'20210107164358_AddAgency_PV')
BEGIN

    CREATE TABLE [Agency] (
        [AgencyId] int NOT NULL IDENTITY,
        [CompanyId] int NOT NULL,
        [AgencyName] nvarchar(100) NOT NULL,
        [Address] nvarchar(100) NULL,
        [Phone] nvarchar(20) NULL,
        [Fax] nvarchar(20) NULL,
        [IsDisable] bit NOT NULL,
        [IsGDPRRemoved] bit NOT NULL,
        CONSTRAINT [PK_Agency] PRIMARY KEY ([AgencyId]),
        CONSTRAINT [FK_Agency_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([CompanyId]) ON DELETE CASCADE
    );

    CREATE TABLE [UserAgency] (
        [ApplicationUserId] int NOT NULL,
        [AgencyId] int NOT NULL,
        CONSTRAINT [PK_UserAgency] PRIMARY KEY ([ApplicationUserId], [AgencyId])
    );

    CREATE INDEX [IX_Agency_CompanyId] ON [Agency] ([CompanyId]);

    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20210107164358_AddAgency_PV', N'3.1.2');
END

GO