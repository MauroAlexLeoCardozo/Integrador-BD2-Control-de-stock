create view VW_ConsumosPendientes as
select p.Nombre + ' ' + p.Apellido as [Nombre y Apellido], i.Nombre, c.Cantidad, c.Fecha
from Consumo c
inner join Insumo i on c.IDInsumo = i.ID
inner join Empleado e on c.IDSolicitante = e.ID
inner join Persona p on e.IDPersona = p.ID
where c.IDAprobador is null and c.Estado = 1