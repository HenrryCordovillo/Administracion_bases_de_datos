CREATE TABLE [catalogo].[FABRICA]
(
[NUMFABRICA] [int] NOT NULL,
[NOMBREFABRICA] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TELEFONO1] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TELEFONO2] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Secundario]
GO
ALTER TABLE [catalogo].[FABRICA] ADD CONSTRAINT [Unique_Identifier5] PRIMARY KEY CLUSTERED ([NUMFABRICA]) ON [Secundario]
GO
