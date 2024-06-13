USE master

GO 

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'gestionAutomotriz4')
BEGIN
	CREATE DATABASE gestionAutomotriz4
	COLLATE Latin1_General_CS_AS;
END

GO

USE gestionAutomotriz4

GO

IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = 'dba')
BEGIN 
	EXEC('CREATE SCHEMA dba')
END

GO

IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = 'venta')
BEGIN 
	EXEC('CREATE SCHEMA venta')
END

GO

IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = 'empleado')
BEGIN 
	EXEC('CREATE SCHEMA empleado')
END

GO


IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'estadoVenta')
BEGIN
	CREATE TABLE dba.estadoVenta
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'estadoAuto')
BEGIN
	CREATE TABLE dba.estadoAuto
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'marca')
BEGIN
	CREATE TABLE dba.marca 
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'modelo')
BEGIN
	CREATE TABLE dba.modelo 
	(
		id int IDENTITY(1,1),
		nombre char(20),
		marcaId int,
		anio date,
		costo decimal(12,2),
		CONSTRAINT FK_MARCA FOREIGN KEY(marcaId) 
		REFERENCES dba.marca(id),
		CONSTRAINT PK_MODELO PRIMARY KEY(id,marcaId)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'sucursal')
BEGIN
	CREATE TABLE dba.sucursal
	(
		id int IDENTITY (1,1) PRIMARY KEY,
		fechaApertura DATE,
		direccion char(50),
		nombre char (50),
		telefono char (8),
		CONSTRAINT CK_TELEFONO CHECK(telefono like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'deposito')
BEGIN
	CREATE TABLE dba.deposito
	(
		id int IDENTITY (1,1) PRIMARY KEY,
		limite int,
		sucursalId int,
		CONSTRAINT FK_SUCURSAL FOREIGN KEY (sucursalId)
		REFERENCES dba.sucursal(id)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'auto')
BEGIN
	CREATE TABLE dba.auto
	(
		id int IDENTITY (1,1),
		modeloId int,
		marcaId int,
		anioFabricacion DATE,
		estado int,
		fechaDepositado DATE,
		idDeposito int,
		CONSTRAINT FK_DEPOSITO FOREIGN KEY (idDeposito)
		REFERENCES dba.deposito(id),
		CONSTRAINT FK_ESTADOAUTO FOREIGN KEY (estado)
		REFERENCES dba.estadoAuto(id),
		CONSTRAINT FK_MODELO FOREIGN KEY (modeloId,marcaId)
		REFERENCES dba.modelo(id,marcaId),
		CONSTRAINT PK_AUTO PRIMARY KEY (id,modeloId,marcaId)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'permiso')
BEGIN
	CREATE TABLE dba.permiso
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'empleado')
BEGIN
	CREATE TABLE dba.empleado
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20),
		apellido char(20),
		fechaIngreso DATE,
		fechaNacimiento DATE,
		dni char(8),
		telefono char(8),
		sucursalId int,
		permisoId int,			
		CONSTRAINT FK_PERMISO FOREIGN KEY (permisoId)
		REFERENCES dba.permiso (id),	
		CONSTRAINT FK_SUCURSAL1 FOREIGN KEY (sucursalId)
		REFERENCES dba.sucursal(id),
		CONSTRAINT CK_DNI CHECK(dni like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		CONSTRAINT CK_TELEFONO1 CHECK(telefono like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	)
END

GO



IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'cliente')
BEGIN
	CREATE TABLE dba.cliente
	(
		id int IDENTITY(1,1) PRIMARY KEY,
		nombre char(20),
		apellido char(20),
		dni char(8),
		telefono char(8),
		CONSTRAINT CK_DNI1 CHECK(dni like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
		CONSTRAINT CK_TELEFONO2 CHECK(telefono like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'venta')
BEGIN
	CREATE TABLE dba.venta
	(
		nroTransaccion int IDENTITY(1,1) PRIMARY KEY,
		fechaVenta smalldatetime,
		clienteId int,
		empleadoId int,
		autoId int,
		autoModeloId int,
		autoMarcaId int,
		estado int,
		finanzasId int,
		CONSTRAINT FK_FINANZAS FOREIGN KEY (finanzasId)
		REFERENCES dba.empleado(id),		
		CONSTRAINT FK_ESTADO1 FOREIGN KEY (estado)
		REFERENCES dba.estadoVenta	(id),
		CONSTRAINT FK_AUTOV FOREIGN KEY (autoId,autoModeloId,autoMarcaId)
		REFERENCES dba.auto (id,modeloId,marcaId),	
		CONSTRAINT FK_CLIENTEV FOREIGN KEY (clienteId)
		REFERENCES dba.cliente (id),	
		CONSTRAINT FK_EMPLEADOV FOREIGN KEY (empleadoId)
		REFERENCES dba.empleado (id),
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'notificacionesPendientes')
BEGIN
	CREATE TABLE dba.notificacionesPendientes (
		id INT IDENTITY(1,1) PRIMARY KEY,
		tipoNotificacion CHAR(50),
		estado CHAR(20) DEFAULT 'Pendiente',
		fechaCreacion DATETIME DEFAULT GETDATE(),
		ventaId INT,     
		CONSTRAINT FK_VENTA FOREIGN KEY (ventaId) 
		REFERENCES dba.venta(nroTransaccion)
	)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dba' AND TABLE_NAME = 'cambioDeposito')
BEGIN
	CREATE TABLE dba.cambioDeposito (
		id INT IDENTITY(1,1) PRIMARY KEY,
		idEmpleadoPideTransaccion int,
		fechaPedido DATETIME,
		idEmpleadoAcepto int,
		fechaAceptado DATETIME,
		idEmpleadoRecibio int,
		fechaRecibido DATETIME,
		autoId int,
		autoModeloId int,
		autoMarcaId int,
		deposito INT,
		CONSTRAINT FK_DEPOSITOCAMBIO FOREIGN KEY (deposito)
		REFERENCES dba.deposito (id),
		CONSTRAINT FK_EMPLEADOPIDE FOREIGN KEY (idEmpleadoPideTransaccion) 
		REFERENCES dba.empleado(id),
		CONSTRAINT FK_EMPLEADOACEPTO FOREIGN KEY (idEmpleadoAcepto) 
		REFERENCES dba.empleado(id),
		CONSTRAINT FK_EMPLEADORECIBIDO FOREIGN KEY (idEmpleadoRecibio) 
		REFERENCES dba.empleado(id),
		CONSTRAINT FK_AUTOCAMBIODEPOSITO FOREIGN KEY (autoId,autoModeloId,autoMarcaId)
		REFERENCES dba.auto (id,modeloId,marcaId)
	)
END

GO

CREATE OR ALTER TRIGGER dba.trIngresoVenta
ON dba.venta
AFTER INSERT
AS
BEGIN 

	DECLARE	@tipoNoti CHAR(50),
			@estado CHAR(20),
			@idVenta int;
	SELECT	@tipoNoti = 'Venta de un automovil',
			@idVenta = (SELECT nroTransaccion FROM inserted);
	INSERT INTO dba.notificacionesPendientes
				(tipoNotificacion,ventaId)
	VALUES(@tipoNoti,@idVenta)
END

GO

--------------------------------------------------------------------------
--Ingresos de estados iniciales
--------------------------------------------------------------------------
IF (SELECT COUNT(*) FROM dba.permiso) = 0
BEGIN
	INSERT INTO dba.permiso(nombre)
	values		('gerente'),
			('vendedor'),
			('finanzas'),
			('deposito')
END

GO

IF(SELECT COUNT(*) FROM dba.estadoAuto) = 0
BEGIN
	INSERT INTO dba.estadoAuto(nombre)
	VALUES			('disponible'),
				('reservado'),
				('vendido'),
				('trasladando')
END

GO

IF(SELECT COUNT(*) FROM dba.estadoVenta) = 0
BEGIN
	INSERT INTO dba.estadoVenta(nombre)
	VALUES			('pendiente'),
				('aceptado'),
				('rechazado')
END

GO

CREATE OR ALTER PROCEDURE dba.ingresarEmpleado
@nombre char(20),
@apellido char(20),
@fechaNacimiento DATE,
@dni char(8),
@telefono char(8),
@idEmpleado int,
@permiso int
AS
BEGIN
	DECLARE @sucursal int
	SET	@sucursal =(SELECT sucursalId FROM dba.empleado WHERE id = @idEmpleado)
	INSERT INTO dba.empleado(nombre,apellido,fechaIngreso,fechaNacimiento,dni,telefono,sucursalId,permisoId)
	VALUES(@nombre,@apellido,GETDATE(),@fechaNacimiento,@dni,@telefono,@sucursal,@permiso)
END

GO




CREATE OR ALTER PROCEDURE dba.ingresarVenta
@nombre char(20),
@apellido char(20),
@dni char(8),
@telefono char(8),
@idAuto int,
@modelo int,
@marca int,
@idEmpleado int

AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION; 
		DECLARE @existe INT;
		SELECT @existe = COUNT(*)
		FROM dba.cliente
		WHERE dni = @dni;
		IF @existe = 0
		BEGIN
			INSERT INTO dba.cliente(nombre, apellido, dni, telefono)
			VALUES(@nombre, @apellido, @dni, @telefono);
		END

		UPDATE dba.auto
		SET estado = 2
		WHERE id = @idAuto;

		INSERT INTO dba.venta(fechaVenta,clienteId,empleadoId,autoId,autoModeloId,autoMarcaId,estado)
		VALUES(GETDATE(),(SELECT id FROM dba.cliente WHERE dni = @dni),@idEmpleado,@idAuto,@modelo,@marca,1)
		
		
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH 
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH;
END

GO

CREATE OR ALTER PROCEDURE venta.aceptarVenta
@idTransaccion int,
@idEmpleado int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE dba.venta
			SET estado = 2,
				finanzasId = @idEmpleado
			WHERE dba.venta.nroTransaccion = @idTransaccion;
			UPDATE dba.auto
			SET estado = 3,
				idDeposito = NULL
			WHERE dba.auto.id IN 
				(SELECT autoId FROM dba.venta
				WHERE dba.venta.nroTransaccion = @idTransaccion);
			UPDATE dba.notificacionesPendientes
			SET estado = 'Aceptado'
			WHERE ventaId = @idTransaccion

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE venta.rechazarVenta
@idTransaccion int,
@idEmpleado int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE dba.venta
			SET estado = 3,
				finanzasId = @idEmpleado
			WHERE dba.venta.nroTransaccion = @idTransaccion;
			UPDATE dba.auto
			SET estado = 1
			WHERE dba.auto.id IN 
				(SELECT autoId FROM dba.venta
				WHERE dba.venta.nroTransaccion = @idTransaccion)
			UPDATE dba.notificacionesPendientes
			SET estado = 'Rechazado'
			WHERE ventaId = @idTransaccion

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END

GO

CREATE OR ALTER PROCEDURE dba.pedirCambioDeposito
@idPedido int,
@idAuto int,
@idDeposito int
AS 
BEGIN
	DECLARE @modelo int,
			@marca int
	
	SELECT	@modelo = modeloId,
			@marca = marcaId
	FROM auto 
	WHERE id = @idAuto
			
	BEGIN TRY
		BEGIN TRANSACTION
		
		IF ((SELECT estado FROM auto WHERE id = @idAuto) = 1 
			AND (SELECT COUNT(*) as cuenta FROM dba.auto WHERE estado = 1 AND idDeposito = @idDeposito) < (SELECT limite FROM dba.deposito WHERE id=@idDeposito))
		BEGIN
			INSERT INTO dba.cambioDeposito (idEmpleadoPideTransaccion,deposito,fechaPedido, autoId, autoModeloId, autoMarcaId)
			VALUES (@idPedido,@idDeposito, GETDATE(), @idAuto, @modelo, @marca);
			
			UPDATE dba.auto
			SET estado = 2
			WHERE id = @idAuto;
		END
		ELSE
		BEGIN 
			THROW 50000, 'No se puede cambiar de depósito el auto seleccionado', 1;
		END
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END

GO

CREATE OR ALTER PROCEDURE dba.aceptarCambioDeposito
@idEmpleado int,
@idAuto int
AS 
BEGIN	
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @sucursal int
		SELECT	@sucursal = d.sucursalId FROM dba.sucursal s
					JOIN dba.deposito d ON s.id = d.sucursalId
					WHERE d.id = (SELECT idDeposito FROM dba.auto WHERE id = @idAuto)

		IF ((SELECT estado FROM auto WHERE id = @idAuto) = 2		
		AND @sucursal = (SELECT sucursalId FROM dba.empleado WHERE id = @idEmpleado))
		BEGIN
			UPDATE dba.cambioDeposito 
			SET		idEmpleadoAcepto = @idEmpleado,
					fechaAceptado = GETDATE()
			WHERE autoId = @idAuto;
			
			UPDATE dba.auto
			SET estado = 4
			WHERE id = @idAuto;

		END
		ELSE
		BEGIN 
			THROW 50001, 'No se puede realizar el cambio', 1;
		END
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END

GO

CREATE OR ALTER PROCEDURE dba.recibirCambioDeposito
@idEmpleado int,
@idAuto int
AS 
BEGIN	
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @deposito int,
				@sucursal int
		SELECT	@sucursal = d.sucursalId FROM dba.sucursal s
					JOIN dba.deposito d ON s.id = d.sucursalId
					WHERE d.id = (SELECT deposito FROM dba.cambioDeposito WHERE autoId = @idAuto)

		SELECT @deposito = deposito 
		FROM dba.cambioDeposito
		WHERE autoId = @idAuto

		IF ((SELECT estado FROM auto WHERE id = @idAuto) = 4 
		AND @sucursal = (SELECT sucursalId FROM dba.empleado WHERE id=@idEmpleado))
		BEGIN
			UPDATE dba.cambioDeposito 
			SET		idEmpleadoRecibio = @idEmpleado,
					fechaRecibido = GETDATE()
			WHERE autoId = @idAuto;

			UPDATE dba.auto
			SET estado = 1,
				idDeposito = @deposito
			WHERE id = @idAuto AND estado = 4;

		END
		ELSE
		BEGIN 
			THROW 50002, 'Este auto no se encuentra trasladando', 1;
		END
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END

GO

-------------------------------------------------------------------
--CREACION DE ROLES
-------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name  = 'rolVendedor')
BEGIN
	CREATE ROLE rolVendedor;
END

GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rolFinanzas')
BEGIN
	CREATE ROLE rolFinanzas;
END

GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rolGerente')
BEGIN
	CREATE ROLE rolGerente;
END

GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rolDeposito')
BEGIN
	CREATE ROLE rolDeposito;
END

GO
--------------------------------------------------------------------------


CREATE or ALTER VIEW empleado.vistaVentas
AS
SELECT 
        v.nroTransaccion AS NroTransaccion,
        v.fechaVenta AS FechaVenta,
        v.autoId AS Identificador,
        m.nombre AS AutoVendido,
		v.empleadoId AS EmpleadoId,
        CONCAT(RTRIM(e.apellido), '-',RTRIM(e.nombre)) AS Vendedor,
        CONCAT(RTRIM(ef.apellido), '-',RTRIM(ef.nombre)) AS EmpleadoFinanzas,
        ev.nombre AS EstadoVenta,
		e.sucursalId AS IdSucursal
FROM 
        dba.venta v
JOIN 
        dba.empleado e ON e.id = v.empleadoId
JOIN 
        dba.empleado ef ON ef.id = v.finanzasId
JOIN 
        dba.auto a ON a.id = v.autoId AND a.modeloId = v.autoModeloId AND a.marcaId = v.autoMarcaId
JOIN 
        dba.modelo m ON m.id = a.modeloId AND m.marcaId = a.marcaId
JOIN 
        dba.estadoVenta ev ON ev.id = v.estado;

GO

CREATE OR ALTER VIEW empleado.vistaAutos
AS
WITH CTE
AS(
	SELECT a.id as id,m.nombre as Modelo,ma.nombre as Marca,a.anioFabricacion as Anio,m.costo as costo,a.estado as Estado,a.idDeposito as Deposito
	FROM dba.auto a
	JOIN dba.modelo m ON a.modeloId = m.id 
	JOIN dba.marca ma ON a.marcaId = ma.id AND m.marcaId = ma.id
)	
SELECT c.id as id,c.Modelo as modelo,c.Marca as marca,c.Anio as anio,c.costo as precio,c.Estado as condicion,c.Deposito as deposito,s.nombre as sucursal,s.id as idSucursal
FROM CTE c
JOIN dba.deposito d ON d.id = c.Deposito
JOIN dba.sucursal s ON s.id = d.sucursalId

GO


CREATE OR ALTER VIEW empleado.vistaNotificacionesPendientes
AS 
SELECT id as ID,tipoNotificacion as tipo,estado as estadoVenta,ventaId as idVenta,fechaCreacion as FechaPedido
FROM dba.notificacionesPendientes
WHERE estado like 'Pendiente'

GO

CREATE OR ALTER PROCEDURE empleado.obtenerVentasVendedor
@idEmpleado int
AS
BEGIN
	SELECT FechaVenta,AutoVendido,EstadoVenta,NroTransaccion 
	FROM empleado.vistaVentas
	WHERE EmpleadoId = @idEmpleado
END

GO

CREATE OR ALTER PROCEDURE empleado.obtenerVentasGerente
@idEmpleado int
AS
BEGIN
	SELECT NroTransaccion,FechaVenta,AutoVendido,EstadoVenta,Vendedor,EmpleadoFinanzas,EstadoVenta 
	FROM empleado.vistaVentas
	WHERE IdSucursal = (SELECT sucursalId FROM dba.empleado WHERE id = @idEmpleado)
END

GO

CREATE OR ALTER PROCEDURE empleado.obtenerAutosEmpleado
AS
BEGIN 
	SELECT id,modelo,marca,anio,precio,deposito,sucursal 
	FROM empleado.vistaAutos
	WHERE condicion = 1
END

GO

CREATE OR ALTER PROCEDURE empleado.obtenerAutosEmpleadoDeposito
@idEmpleado int
AS
BEGIN 
	DECLARE @sucursalEmpleado int;
	SELECT @sucursalEmpleado= sucursalId FROM dba.empleado WHERE id =@idEmpleado ;

	SELECT id,modelo,marca,anio,precio,deposito,sucursal,idSucursal 
	FROM empleado.vistaAutos
	WHERE condicion = 1 AND idSucursal =@sucursalEmpleado

END

GO

CREATE OR ALTER PROCEDURE dba.asignarRolConLogin
    @idEmpleado INT,
    @password NVARCHAR(20)
AS  
BEGIN
    DECLARE @login NVARCHAR(40),
            @tipoUser NVARCHAR(20),
            @sql NVARCHAR(MAX);

    SELECT @login = CONCAT(RTRIM(apellido), '-', RTRIM(dni))
    FROM dba.empleado
    WHERE id = @idEmpleado;

    SET @tipoUser = CASE (SELECT permisoId FROM dba.empleado WHERE id = @idEmpleado)
        WHEN 1 THEN 'rolGerente'
        WHEN 2 THEN 'rolVendedor'
        WHEN 3 THEN 'rolFinanzas'
        ELSE 'rolDeposito'
    END;

    BEGIN TRY
        BEGIN TRANSACTION
            IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = @login)
            BEGIN
                SET @sql = 'CREATE LOGIN [' + @login + '] WITH PASSWORD = ''' + @password + ''';';
                EXEC sp_executesql @sql;
            END

            IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = @login)
            BEGIN
                SET @sql = 'CREATE USER [' + @login + '] FOR LOGIN [' + @login + '];';
                EXEC sp_executesql @sql;
            END

            SET @sql = 'ALTER ROLE [' + @tipoUser + '] ADD MEMBER [' + @login + '];';
            EXEC sp_executesql @sql;

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END

GO
-------------------------------------------------------------------
--CREACION DE PERMISOS
-------------------------------------------------------------------
GRANT SELECT ON OBJECT :: [empleado].[vistaNotificacionesPendientes] to rolFinanzas;
GRANT SELECT ON OBJECT :: [empleado].[vistaAutos] to rolGerente; 
GRANT EXECUTE ON OBJECT :: [empleado].[obtenerVentasVendedor] to rolVendedor;
GRANT EXECUTE ON OBJECT :: [empleado].[obtenerAutosEmpleado] to rolVendedor; 
GRANT EXECUTE ON OBJECT :: [empleado].[obtenerVentasGerente] to rolGerente;
GRANT EXECUTE ON OBJECT :: [empleado].[obtenerVentasGerente] to rolFinanzas;
GRANT EXECUTE ON OBJECT :: [dba].[pedirCambioDeposito] to rolGerente;
GRANT EXECUTE ON OBJECT :: [dba].[aceptarCambioDeposito] to rolDeposito;
GRANT EXECUTE ON OBJECT :: [dba].[recibirCambioDeposito] to rolDeposito;
GRANT EXECUTE ON OBJECT :: [dba].[ingresarVenta] to rolVendedor;
GRANT EXECUTE ON OBJECT :: [venta].[aceptarVenta] to rolFinanzas;
GRANT EXECUTE ON OBJECT :: [venta].[rechazarVenta] to rolFinanzas;
GRANT EXECUTE ON OBJECT :: [empleado].[obtenerAutosEmpleadoDeposito] to rolDeposito;
GRANT EXECUTE ON OBJECT :: [dba].[ingresarEmpleado] to rolGerente;

 
--------------------------------------------------------------------
--Pruebas de funcionamiento
--------------------------------------------------------------------
-----------------------------------------------------------
--Todas las contraseñas son prueba y el log el [Apellido-dni],ejecutar una a la vez
-----------------------------------------------------------
/*
DECLARE	@idEmp int,
		@contra nvarchar(20)
SELECT	@idEmp = 1,
		@contra = 'prueba'
EXEC [dba].[asignarRolConLogin] @idEmp,@contra

DECLARE	@idEmp int,
		@contra nvarchar(20)
SELECT	@idEmp = 2,
		@contra = 'prueba'
EXEC [dba].[asignarRolConLogin] @idEmp,@contra

DECLARE	@idEmp int,
		@contra nvarchar(20)
SELECT	@idEmp = 3,
		@contra = 'prueba'
EXEC [dba].[asignarRolConLogin] @idEmp,@contra

DECLARE	@idEmp int,
		@contra nvarchar(20)
SELECT	@idEmp = 4,
		@contra = 'prueba'
EXEC [dba].[asignarRolConLogin] @idEmp,@contra

DECLARE	@idEmp int,
		@contra nvarchar(20)
SELECT	@idEmp = 5,
		@contra = 'prueba'
EXEC [dba].[asignarRolConLogin] @idEmp,@contra

*/
GO

IF (SELECT COUNT(*) AS cuenta FROM dba.marca) = 0
BEGIN 
	INSERT INTO dba.marca(nombre)
	VALUES	('Fiat'),
			('MercedezBenz'),
			('Peugeot'),
			('Chevrolet')
END

GO

IF (SELECT COUNT(*) AS cuenta FROM dba.modelo) = 0
BEGIN 
	INSERT INTO dba.modelo(nombre,marcaId,anio,costo)
	VALUES	('A1',1,'2020-01-01',10000000),
			('A2',1,'2021-01-01',20000000),
			('A3',1,'2022-01-01',30000000),
			('A4',1,'2023-01-01',40000000),
			('B1',2,'2020-02-01',100000000),
			('B2',2,'2021-02-01',200000000),
			('B3',2,'2022-02-01',300000000),
			('B4',2,'2023-02-01',400000000),
			('C1',3,'2020-03-01',50000000),
			('C2',3,'2021-03-01',60000000),
			('C3',3,'2022-03-01',70000000),
			('C4',3,'2023-03-01',80000000),
			('D1',4,'2020-04-01',500000000),
			('D2',4,'2021-04-01',600000000),
			('D3',4,'2022-04-01',700000000),
			('D4',4,'2023-04-01',800000000)
END

GO

IF (SELECT COUNT(*) AS cuenta FROM dba.sucursal) = 0
BEGIN 
	INSERT INTO dba.sucursal(fechaApertura,direccion,nombre,telefono)
	VALUES	('2020-06-08','Rivadavia 1500','ABCDE','12345678'),
			('2019-03-05','Avenida Gaona 523','FGHIJ','87654321')
END

GO

IF (SELECT COUNT(*) AS cuenta FROM dba.deposito) = 0
BEGIN 
	INSERT INTO dba.deposito(limite,sucursalId)
	VALUES	(10,1),
			(15,1),
			(20,2),
			(5,2)

END

GO

IF (SELECT COUNT(*) AS cuenta FROM dba.auto) = 0
BEGIN 
INSERT INTO dba.auto(modeloId, marcaId, anioFabricacion, estado, fechaDepositado, idDeposito)
VALUES
    (1, 1, '2020-01-01', 1, '2022-05-10', 1),
    (2, 1, '2021-01-01', 1, '2022-06-15', 1),
    (3, 1, '2022-01-01', 1, '2022-07-20', 2),
    (4, 1, '2023-01-01', 1, '2022-08-25', 2),
    (5, 2, '2020-02-01', 1, '2022-09-30', 3),
    (6, 2, '2021-02-01', 1, '2022-10-05', 3),
    (7, 2, '2022-02-01', 1, '2022-11-10', 4),
    (8, 2, '2023-02-01', 1, '2022-12-15', 4),
    (9, 3, '2020-03-01', 1, '2023-01-20', 1),
    (10, 3, '2021-03-01', 1, '2023-02-25', 1),
    (11, 3, '2022-03-01', 1, '2023-03-30', 2),
    (12, 3, '2023-03-01', 1, '2023-04-05', 2),
    (13, 4, '2020-04-01', 1, '2023-05-10', 3),
    (14, 4, '2021-04-01', 1, '2023-06-15', 3),
    (15, 4, '2022-04-01', 1, '2023-07-20', 4),
    (16, 4, '2023-04-01', 1, '2023-08-25', 4)
END

GO

IF (SELECT COUNT(*) AS cuenta FROM dba.empleado) = 0
BEGIN 
	INSERT INTO dba.empleado(nombre,apellido,dni,fechaIngreso,fechaNacimiento,sucursalId,telefono,permisoId)
	VALUES	('Franco','Porcile','12345678',GETDATE(),'1998-09-27',1,'44444444',1),
			('Lucio','Depo2','87654321',GETDATE(),'2007-03-27',2,'55555555',4),
			('Abcd','Ventas1','23546545',GETDATE(),'2000-03-15',1,'55544445',2),			
			('Dddd','Finanzas1','21111545',GETDATE(),'2000-01-05',1,'55542245',3),
			('Franco','Depo1','61258218',GETDATE(),'1998-09-07',1,'44412345',4)
END

GO
/*
--------------------------------------------------------------
--Prueba de aceptado
--------------------------------------------------------------
DECLARE	@nombre char(20),
		@apellido char(20),
		@dni char(8),
		@telefono char(8),
		@idAuto int,
		@modelo int,
		@marca int,
		@idEmpleado int
SELECT	@nombre ='miCompra',
		@apellido ='Compra1',
		@dni ='54689712',
		@telefono ='11111111',
		@idAuto =1,
		@modelo =1,
		@marca =1,
		@idEmpleado =3
EXEC dba.ingresarVenta @nombre,@apellido,@dni,@telefono,@idAuto,@modelo,@marca,@idEmpleado;

GO 

DECLARE @idTransaccion int,
		@idEmpleado int
SELECT	@idTransaccion =1,
		@idEmpleado =4
EXEC venta.aceptarVenta @idTransaccion,@idEmpleado
-------------------------------------------------------
--Prueba de rechazo
-------------------------------------------------------

DECLARE	@nombre char(20),
		@apellido char(20),
		@dni char(8),
		@telefono char(8),
		@idAuto int,
		@modelo int,
		@marca int,
		@idEmpleado int
SELECT	@nombre ='miCompra2',
		@apellido ='Compra2',
		@dni ='54689722',
		@telefono ='11222221',
		@idAuto =2,
		@modelo =2,
		@marca =1,
		@idEmpleado =3
EXEC dba.ingresarVenta @nombre,@apellido,@dni,@telefono,@idAuto,@modelo,@marca,@idEmpleado;

GO 

DECLARE @idTransaccion int,
		@idEmpleado int
SELECT	@idTransaccion =2,
		@idEmpleado =4
EXEC venta.rechazarVenta @idTransaccion,@idEmpleado
*/
/*
---------------------------------------------------------
--Prueba de transferencia
---------------------------------------------------------

SELECT * FROM dba.auto
SELECT * FROM dba.cambioDeposito

DECLARE	@pide int,
		@idauto int,
		@idNDep int 
SELECT	@pide =1,
		@idauto =3,
		@idNDep =3
EXEC dba.pedirCambioDeposito @pide,@idauto,@idNDep

SELECT * FROM dba.empleado
SELECT * FROM dba.auto
SELECT * FROM dba.cambioDeposito 
-----------------------------------------------------------
--Empleado de sucursal 2 no puede aceptar el cambio
-----------------------------------------------------------

DECLARE @idEmpleado int,
		@idAuto1 int
SELECT	@idEmpleado = 5,
		@idAuto1 = 3
EXEC dba.aceptarCambioDeposito @idEmpleado,@idAuto1
-----------------------------------------------------------
--Empleado de sucursal 2 puede aceptar el cambio
-----------------------------------------------------------
go

SELECT * FROM dba.empleado
SELECT * FROM dba.auto
SELECT * FROM dba.cambioDeposito 


DECLARE @idEmpleado int,
		@idAuto2 int
SELECT	@idEmpleado = 2,
		@idAuto2 = 3
EXEC dba.recibirCambioDeposito @idEmpleado,@idAuto2

*/
