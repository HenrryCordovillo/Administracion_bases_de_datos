CREATE TABLE [movimientos].[PRODUCCION]
(
[NUMPRODUCTO] [int] NOT NULL,
[NUMFABRICA] [int] NOT NULL,
[CANTIDADPRODUCTO] [int] NULL,
[FECHAPRODUCCION] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[PRODUCCION] ADD CONSTRAINT [Unique_Identifier6] PRIMARY KEY CLUSTERED ([NUMPRODUCTO], [NUMFABRICA]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[PRODUCCION] ADD CONSTRAINT [Esta] FOREIGN KEY ([NUMPRODUCTO]) REFERENCES [catalogo].[PRODUCTO] ([NUMPRODUCTO])
GO
ALTER TABLE [movimientos].[PRODUCCION] ADD CONSTRAINT [Tiene] FOREIGN KEY ([NUMFABRICA]) REFERENCES [catalogo].[FABRICA] ([NUMFABRICA])
GO
