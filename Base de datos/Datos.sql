use ControlStockVeta
go

INSERT INTO Empresa (Nombre, Estado) 
VALUES 
('Martelli', 1),
('Rodriguez', 1);
GO

INSERT INTO Rango (Nombre, Estado) 
VALUES 
('Operario', 1),
('Lider', 1),
('Gerente', 1);
GO

INSERT INTO TipoAcceso (Nombre, Estado) 
VALUES 
('Operativo', 1),           -- Solo pide insumos
('Aprobador', 1),           -- Pide y aprueba insumos
('Administrador', 1);		-- Acceso completo al sistema
GO

INSERT INTO Persona (Nombre, Apellido, DNI, Nacimiento, Estado) 
VALUES 
('Mauro Alexis', 'Cardozo', '40123456', '1998-05-15', 1), -- ID 1
('Roberto', 'Gómez', '32456789', '1985-11-20', 1),        -- ID 2
('Lucía', 'Fernández', '41987654', '2000-02-10', 1),      -- ID 3
('Carlos', 'Mendez', '35111222', '1990-08-10', 1),        -- ID 4
('Ana', 'Soria', '38999888', '1995-12-05', 1);			  -- ID 5
GO

INSERT INTO Proveedor (Nombre, Estado) 
VALUES 
('Delta', 1),
('Distribuidora mayorista', 1);
GO

-- Departamentos (Asignados a la empresa)
INSERT INTO Departamento (IDEmpresa, Nombre, Estado) 
VALUES 
(1, 'Desarrollo e inovacion', 1), 
(1, 'Control de calidad', 1),
(2, 'Deposito y logistica', 1),
(2, 'Mantenimiento y limpieza', 1);
GO

-- Insumos (Asignados)
-- El stock inicial es 0, a la espera del primer ingreso real por sistema
INSERT INTO Insumo (IDEmpresa, Nombre, Stock, Estado) 
VALUES 
(1, 'Lavandina Concentrada 5L', 0, 1), 
(1, 'Escoba de Cerda Reforzada', 0, 1),  
(1, 'Desodorante de Piso 5L', 0, 1),
(2, 'Lavandina Concentrada 5L', 0, 1),
(2, 'Trapo de piso de algodon', 0, 1);
GO

-- Empleados (Conectando Personas, Departamentos, Rangos y Accesos)
INSERT INTO Empleado (IDPersona, IDDepartamento, IDRango, IDAcceso, Estado) 
VALUES
-- Mauro (Desarrollo e inovacion, Gerente, Administrador)
(1, 1, 3, 3, 1), 
-- Roberto (Control de calidad, Lider, Operativo)
(2, 2, 2, 1, 1), 
-- Lucia (Deposito y logistica, Operario, Operativo)
(3, 3, 1, 1, 1),
-- Carlos (Deposito y logistica, Lider, Aprobador)
(4, 3, 2, 2, 1),
-- Ana (Mantenimiento y limpieza, Operario, Operativo)
(5, 4, 1, 1, 1);
GO

insert into Ingreso (IDInsumo, IDProveedor, Precio, Cantidad, CantDisponible, Fecha, Estado)
values
(1, 1, 4500.00, 20, 18, '2026-07-01', 1), 
(2, 2, 1500.00, 10, 10, '2026-07-05', 1), 
(3, 1, 3000.00, 15, 15, '2026-07-10', 1),
(4, 2, 4600.00, 10, 10, '2026-07-02', 1), 
(5, 1, 800.00, 50, 45, '2026-07-08', 1);
GO

INSERT INTO Consumo (IDInsumo, IDSolicitante, IDAprobador, Cantidad, CostoTotal, Fecha, Estado) 
VALUES 
(1, 2, 1, 2, 9000.00, '2026-07-15', 1),
(2, 2, NULL, 1, 0.00, '2026-07-16', 1),
(5, 3, 4, 5, 4000.00, '2026-07-17', 1),
(4, 5, NULL, 2, 0.00, '2026-07-18', 1);
GO

UPDATE Insumo SET Stock = 18 WHERE ID = 1;
UPDATE Insumo SET Stock = 10 WHERE ID = 2;
UPDATE Insumo SET Stock = 15 WHERE ID = 3;
UPDATE Insumo SET Stock = 10 WHERE ID = 4;
UPDATE Insumo SET Stock = 45 WHERE ID = 5;
GO