use ControlStockVeta;
go

create procedure sp_ReporteConsumoPorSector
	@fechaInicio date,
	@fechaFin date,
	@IDDepartamento int
as
begin
	select
		d.nombre as Departamento,
		i.Nombre as Insumo,
		sum(c.Cantidad) as TotalUnidadesConsumidas,
		count(c.ID) as CantidadDePedidosRealizados
	from Consumo c
	inner join Insumo i on c.IDInsumo = i.ID
	inner join Empleado e on c.IDSolicitante = e.ID
	inner join Departamento d on e.IDDepartamento = d.ID
	where e.IDDepartamento = @IDDepartamento
		and cast(c.Fecha as date) between @fechaInicio and @fechaFin
		and c.IDAprobador is not null
		and c.Estado = 1
	group by d.Nombre, i.Nombre
	order by TotalUnidadesConsumidas desc;
end;
go