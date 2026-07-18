create view VW_StockOperativo as
select
	e.nombre Empresa,
	i.nombre Insumo,
	i.stock Stock
from insumo i
join empresa e on i.idEmpresa = e.ID
where i.Estado = 1