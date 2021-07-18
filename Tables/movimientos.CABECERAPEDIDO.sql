CREATE TABLE [movimientos].[CABECERAPEDIDO]
(
[NUMPEDIDO] [int] NOT NULL,
[NUMCLIENTE] [int] NOT NULL,
[FECHAPEDIDO] [datetime] NULL,
[TipoPed] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MontoTotal] [money] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[CabeceraPedidoIngresado] 
on [movimientos].[CABECERAPEDIDO] for insert 
as
declare @num_pedi int, @fech_ped datetime, @tipo_ped varchar(10), @mont_total money,
@num_cli int, @cod_gar int, @lim_cred money
select @num_pedi = NumPedido, @fech_ped = FechaPedido, @tipo_ped = TipoPed, @mont_total = 
MontoTotal, @num_cli = NumCliente from inserted
select @cod_gar = (select CodigoGarante from catalogo.Cliente where NumCliente = @num_cli),
@lim_cred = (select LimitCredito from catalogo.Cliente where NumCliente = @num_cli) 
IF @tipo_ped = 'CREDITO'
BEGIN
IF NOT EXISTS (SELECT * FROM Deudor WHERE CodigoCliente = @num_cli) 
BEGIN
insert into Deudor values (@num_cli, @cod_gar, @lim_cred, 0)
END
END 
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[TR_PedidoActualizado]
on [movimientos].[CABECERAPEDIDO] for update
as
declare @num_pedi int, @fech_pedi datetime, @num_cli int
select @num_pedi = NUMPEDIDO, @fech_pedi = FECHAPEDIDO, @num_cli = NUMCLIENTE from
inserted
update movimientos.CabezaCuerpoP set FECHAPEDIDO = @fech_pedi where NUMPEDIDO =
@num_pedi and NUMCLIENTE = @num_cli
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[TR_PedidoEliminado]
on [movimientos].[CABECERAPEDIDO] for delete 
as
declare @num_pedi int, @fech_pedi datetime, @num_cli int
select @num_pedi = NUMPEDIDO, @fech_pedi = FECHAPEDIDO, @num_cli = NUMCLIENTE from 
deleted
delete from movimientos.CabezaCuerpoP where FECHAPEDIDO = @fech_pedi and NUMPEDIDO
= @num_pedi and NUMCLIENTE = @num_cli
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[TR_PedidoInsertado]
on [movimientos].[CABECERAPEDIDO] for insert 
as
declare @num_pedi int, @fech_pedi datetime, @num_cli int
select @num_pedi = NUMPEDIDO, @fech_pedi = FECHAPEDIDO, @num_cli = NUMCLIENTE from 
inserted
insert into movimientos.CabezaCuerpoP Values
(@num_pedi,@fech_pedi,@num_cli,null,null,null) 
GO
ALTER TABLE [movimientos].[CABECERAPEDIDO] ADD CONSTRAINT [CK_CabeceraPedido] CHECK (([TipoPed]='CREDITO' OR [TipoPEd]='CONTADO'))
GO
ALTER TABLE [movimientos].[CABECERAPEDIDO] ADD CONSTRAINT [Unique_Identifier2] PRIMARY KEY CLUSTERED ([NUMPEDIDO]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[CABECERAPEDIDO] ADD CONSTRAINT [Hace] FOREIGN KEY ([NUMCLIENTE]) REFERENCES [catalogo].[CLIENTE] ([NUMCLIENTE])
GO
