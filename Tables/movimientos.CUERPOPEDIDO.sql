CREATE TABLE [movimientos].[CUERPOPEDIDO]
(
[NUMPEDIDO] [int] NOT NULL,
[NUMPRODUCTO] [int] NOT NULL,
[PRECIOUNITARIO] [money] NULL,
[CANTIDAD] [int] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [movimientos].[CK_CuerpoPedidoInsertado]
on [movimientos].[CUERPOPEDIDO] for insert
as
declare @pre_uni money, @cant int, @num_pro int, @num_ped int, @num_cli int, @lim_cred money,
@sal_deu money
select @pre_uni = PrecioUnitario, @cant = Cantidad, @num_pro = NumProducto, @num_ped =
NumPedido from inserted
select @num_cli = (select NumCliente from movimientos.CabeceraPedido where NumPedido =
@num_ped)
select @lim_cred = (select LimitCredito from catalogo.Cliente where NumCliente = @num_cli)
select @sal_deu = (select SaldoDeudor from Deudor where CodigoCliente = @num_cli)
update movimientos.CabeceraPedido set MontoTotal = MontoTotal + (@cant * @pre_uni) where
NumPedido = @num_ped
IF (@lim_cred - @sal_deu) >= @cant * @pre_uni
BEGIN
update Deudor set SaldoDeudor = SaldoDeudor + (@cant * @pre_uni) where CodigoCliente =
@num_cli
END 
ELSE 
BEGIN
ROLLBACK TRANSACTION 
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[TR_ProductoActualizado] 
on [movimientos].[CUERPOPEDIDO] for update 
as
declare @pre_uni money, @cant int, @num_pro int, @num_pedi int
select @pre_uni = PRECIOUNITARIO, @cant = CANTIDAD, @num_pro = NUMPRODUCTO, @num_pedi= NUMPEDIDO from inserted
update movimientos.CabezaCuerpoP set PRECIOUNITARIO = @pre_uni, CANTIDAD = @cant where
NUMPEDIDO = @num_pedi and NUMPRODUCTO = @num_pro
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE TRIGGER [movimientos].[TR_ProductoEliminado] 
on [movimientos].[CUERPOPEDIDO] for delete 
as
declare @pre_uni money, @cant int, @num_pro int, @num_pedi int
select @pre_uni = PRECIOUNITARIO, @cant = CANTIDAD, @num_pro = NUMPRODUCTO, @num_pedi
= NUMPEDIDO from deleted
delete from movimientos.CabezaCuerpoP where PRECIOUNITARIO = @pre_uni and CANTIDAD =
@cant and NUMPEDIDO = @num_pedi and NUMPRODUCTO = @num_pro
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[TR_ProductoInsertado] 
on [movimientos].[CUERPOPEDIDO] for insert 
as
declare @pre_uni money, @cant int, @num_pro int, @num_pedi int
select @pre_uni = PRECIOUNITARIO, @cant = CANTIDAD, @num_pro = NUMPRODUCTO, @num_pedi = NUMPEDIDO from inserted
update movimientos.CabezaCuerpoP set PRECIOUNITARIO = @pre_uni, CANTIDAD = @cant, NUMPRODUCTO
= @num_pro where NUMPEDIDO = @num_pedi
GO
ALTER TABLE [movimientos].[CUERPOPEDIDO] ADD CONSTRAINT [Unique_Identifier3] PRIMARY KEY CLUSTERED ([NUMPRODUCTO], [NUMPEDIDO]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[CUERPOPEDIDO] ADD CONSTRAINT [Contiene] FOREIGN KEY ([NUMPEDIDO]) REFERENCES [movimientos].[CABECERAPEDIDO] ([NUMPEDIDO])
GO
ALTER TABLE [movimientos].[CUERPOPEDIDO] ADD CONSTRAINT [Forma parte] FOREIGN KEY ([NUMPRODUCTO]) REFERENCES [catalogo].[PRODUCTO] ([NUMPRODUCTO])
GO
