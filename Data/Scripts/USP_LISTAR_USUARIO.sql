 ALTER PROCEDURE [dbo].[USP_LISTAR_USUARIOS]          
            
	@nOpcion INT = 0,   
	@pParametro VARCHAR(max)
	
AS     

BEGIN
	
	BEGIN
		
		DECLARE @IdUsuario INT;
		
	END
	
	--VARIABLE TABLA
	BEGIN

		DECLARE @tParametro TABLE (
			id int,
			valor varchar(max)
		);

	END

	--Descontena el parametro con split
	BEGIN
		IF(LEN(LTRIM(RTRIM(@pParametro))) > 0)
			BEGIN
			    INSERT INTO @tParametro (id, valor ) SELECT id, valor FROM dbo.Split(@pParametro, '|');
			END;
	END;

	IF @nOpcion = 1   --CONSULTAR TODO  --Lista de Disponibilidad->Todos
	BEGIN	                                                                                                                                                     
			SELECT 
				usr.IdUsuario, 
				 CONCAT(TRIM(per.PrimerNombre), ' ', IIF(TRIM(per.SegundoNombre) = '', '', CONCAT(TRIM(per.SegundoNombre), ' ')), 
				TRIM(per.ApellidoPaterno), ' ', TRIM(per.ApellidoMaterno)) AS 'Nombres',	
				usr.Correo,
				rol.Nombre AS 'Rol',
				usr.Activo
			FROM [Usuario] usr
			INNER JOIN [Persona] per ON usr.IdPersona = per.IdPersona
			JOIN UsuarioRol usrol	ON  usr.IdUsuario = usrol.IdUsuario
			JOIN [Rol] rol ON usrol.IdRol = rol.IdRol 
			ORDER BY				
				usr.IdUsuario
				
                                                                                 
	END;                                     
		
	ELSE IF @nOpcion = 2  --CONSULTAR POR ID 
	BEGIN
		BEGIN			
			SET @IdUsuario = cast((SELECT valor FROM @tParametro WHERE id = 1) AS INT);
		END	
		
		BEGIN
			SELECT 
				usr.IdUsuario, 
				per.PrimerNombre,
				per.SegundoNombre, 
				per.ApellidoPaterno,
				per.ApellidoMaterno,
				per.Celular,
				usr.Correo,
				rol.Nombre AS 'Rol',
				usr.Activo
			FROM [Usuario] usr
			INNER JOIN [Persona] per ON usr.IdPersona = per.IdPersona
			JOIN UsuarioRol usrol	ON  usr.IdUsuario = usrol.IdUsuario
			JOIN [Rol] rol ON usrol.IdRol = rol.IdRol 
			WHERE 
				usr.IdUsuario = @IdUsuario

		END
	END;	           	 
	
END
