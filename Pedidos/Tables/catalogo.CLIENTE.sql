CREATE TABLE [catalogo].[CLIENTE]
(
[NUMCLIENTE] [int] NOT NULL,
[NOMBRECLIENTE] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIRECENVIO] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LIMITCREDITO] [money] NULL,
[DESCUENTO] [int] NULL,
[CIUDAD] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodigoGarante] [int] NOT NULL
) ON [Secundario]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [catalogo].[ClienteIngresado]
on [catalogo].[CLIENTE] for insert
as
declare @num_cli int, @cod_gar int
select @num_cli = NumCliente, @cod_gar = CodigoGarante from inserted 
IF EXISTS (SELECT * FROM Deudor WHERE CodigoCliente = @cod_gar) 
BEGIN
PRINT 'entro en el if'
ROLLBACK TRANSACTION 
END
ELSE
BEGIN
PRINT 'entro en el else' 
END
GO
ALTER TABLE [catalogo].[CLIENTE] ADD CONSTRAINT [Unique_Identifier1] PRIMARY KEY CLUSTERED ([NUMCLIENTE]) ON [Secundario]
GO
CREATE NONCLUSTERED INDEX [IX_Puede Ser] ON [catalogo].[CLIENTE] ([CodigoGarante]) ON [Secundario]
GO
ALTER TABLE [catalogo].[CLIENTE] ADD CONSTRAINT [Puede Ser] FOREIGN KEY ([CodigoGarante]) REFERENCES [catalogo].[CLIENTE] ([NUMCLIENTE])
GO
