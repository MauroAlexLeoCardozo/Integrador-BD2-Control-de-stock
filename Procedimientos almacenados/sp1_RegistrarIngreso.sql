use ControlStockVeta;
go

create procedure sp_RegistrarIngreso
	@IDInsumo int,
	@IDProveedor int,
	@Cantidad int,
	@Precio decimal(18,2)
as
begin
	if @Cantidad <= 0 or @Precio <= 0
	begin
	raiserror('La cantidad y el precio deben ser mayores a cero.', 16, 1);
		return;
	end
insert into Ingreso (IDInsumo, IDProveedor, Precio, Cantidad, CantDisponible, Fecha, Estado)
values (@IDInsumo, @IDProveedor, @Precio, @Cantidad, @Cantidad, getdate(), 1);
end
go