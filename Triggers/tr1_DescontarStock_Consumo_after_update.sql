Use ControlStockVeta;
go

create trigger tr_DescontarStock_Consumo_after_update
on Consumo
after update
as
begin
	if update(IDAprobador)
		begin
		update i
		set i.Stock = i.Stock - ins.Cantidad
		from Insumo i
		inner join inserted ins on i.ID = ins.IDInsumo
		inner join deleted del on ins.ID = del.ID
		where del.Estado = 1
		and ins.IDAprobador is not null
		and del.IDAprobador is null;
	end
end;