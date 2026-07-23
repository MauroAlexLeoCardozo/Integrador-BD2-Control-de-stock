use ControlStockVeta;
go

create trigger tr_RevertirStock_Consumo_after_delete
on consumo
after delete
as
begin
	update i
	set i.Stock = i.Stock + del.Cantidad
	from Insumo i
	inner join deleted del on i.ID = del.IDInsumo
	where del.IDAprobador is not null;
end;
go