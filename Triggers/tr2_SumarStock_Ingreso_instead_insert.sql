use ControlStockVeta;
go

create trigger tr_SumarStock_Ingreso_instead_insert
on ingreso
instead of insert
as
begin
	Insert into Ingreso (IDInsumo, IDProveedor, Precio, Cantidad, CantDisponible, Fecha, Estado)
	select IDInsumo, IDProveedor, Precio, Cantidad, Cantidad, getdate(), 1
	from inserted;

	update i
	set i.Stock = i.Stock + ins.Cantidad
	from Insumo i
	inner join inserted ins on i.ID = ins.IDInsumo;
end;