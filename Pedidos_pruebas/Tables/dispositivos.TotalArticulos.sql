CREATE TABLE [dispositivos].[TotalArticulos]
(
[IdArticulo] [int] NOT NULL,
[TotalPedidos] [int] NULL
) ON [Dispositivos]
GO
ALTER TABLE [dispositivos].[TotalArticulos] ADD CONSTRAINT [Unique_Identifier1] PRIMARY KEY CLUSTERED ([IdArticulo]) ON [Dispositivos]
GO
