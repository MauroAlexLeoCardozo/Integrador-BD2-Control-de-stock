create view VW_CatalogoEmpleados as
select e.Nombre as Empresa, d.Nombre as Departamento, p.Nombre + ' ' + p.Apellido as [Nombre y Apellido], r.Nombre as Rango
from Empresa e
inner join Departamento d on e.ID = d.IDEmpresa
inner join Empleado em on d.ID = em.IDDepartamento
inner join Persona p on em.IDPersona = p.ID
inner join Rango r on em.IDRango = r.ID
where e.Estado = 1 and d.Estado = 1 and em.Estado = 1 and p.Estado = 1 and r.Estado = 1