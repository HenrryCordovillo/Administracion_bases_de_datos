CREATE TABLE [dbo].[Pagos]
(
[CodigoCliente] [int] NOT NULL,
[FechaPago] [datetime] NOT NULL,
[ValorPago] [money] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[CK_PagoIngresado] 
on [dbo].[Pagos] for insert
as
declare @cod_cli int, @fech_pag datetime, @val_pag money
select @cod_cli = CodigoCliente, @fech_pag = FechaPago, @val_pag = ValorPago from inserted 
update Deudor set SaldoDeudor = SaldoDeudor - @val_pag where CodigoCliente = @cod_cli
GO
ALTER TABLE [dbo].[Pagos] ADD CONSTRAINT [Unique_Identifier8] PRIMARY KEY CLUSTERED ([CodigoCliente], [FechaPago]) ON [PRIMARY]
GO
