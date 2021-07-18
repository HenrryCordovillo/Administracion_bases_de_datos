CREATE TABLE [dbo].[Deudor]
(
[CodigoCliente] [int] NOT NULL,
[CodigoGarante] [int] NULL,
[LimiteCredito] [money] NULL,
[SaldoDeudor] [money] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DeudorActualizado]
on [dbo].[Deudor] for update
as
declare @sal_deudor money, @cod_cli int
select @sal_deudor = SaldoDeudor, @cod_cli = CodigoCliente from inserted
IF(@sal_deudor = 0) 
BEGIN
delete from Deudor where CodigoCliente = @cod_cli
END
GO
ALTER TABLE [dbo].[Deudor] ADD CONSTRAINT [Unique_Identifier7] PRIMARY KEY CLUSTERED ([CodigoCliente]) ON [PRIMARY]
GO
