 ALTER PROCEDURE [dbo].[USP_MNT_Usuarios]          
            
	@nOpcion INT = 0,   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @IdUsuario INT;
		DECLARE @IdPersona INT;
		DECLARE @Password VARBINARY
		DECLARE @Correo VARCHAR(MAX)
		DECLARE @PrimerNombre VARCHAR(MAX)
		DECLARE @SegundoNombre VARCHAR(MAX)
		DECLARE @ApellidoPaterno VARCHAR(MAX)
		DECLARE @ApellidoMaterno VARCHAR(MAX)
		DECLARE @Roles VARCHAR(MAX);
		DECLARE @Celular VARCHAR(MAX);
		DECLARE @Activo BIT;

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
        
		
  IF @nOpcion = 3  --INSERTAR  (R)                                                        
	BEGIN
		BEGIN
			SET @Correo				= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @PrimerNombre		= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @SegundoNombre		= (SELECT valor FROM @tParametro WHERE id = 3);
			SET @ApellidoPaterno	= (SELECT valor FROM @tParametro WHERE id = 4);
			SET @ApellidoMaterno	= (SELECT valor FROM @tParametro WHERE id = 5);
			SET @Roles				= (SELECT valor FROM @tParametro WHERE id = 6);			
			SET @Celular			= (SELECT valor FROM @tParametro WHERE id = 7);
			--SET @nIdRol				= cast((SELECT valor FROM @tParametro WHERE id = 6) AS INT);
			--SET @Contrasenia		= (SELECT valor FROM @tParametro WHERE id = 10);
		END	

		BEGIN
			SET @Password = CAST('123' AS varbinary)			
		END

		BEGIN

			BEGIN TRAN
				BEGIN TRY
					BEGIN
						
						INSERT INTO Persona
								(PrimerNombre, SegundoNombre, ApellidoPaterno, ApellidoMaterno, Celular)
						VALUES	(@PrimerNombre, @SegundoNombre, @ApellidoPaterno, @ApellidoMaterno, @Celular)

						SET @IdPersona = SCOPE_IDENTITY()

						INSERT INTO Usuario
								(IdPersona, Correo,  PasswordHash, Activo)
						VALUES	(@IdPersona,@Correo, @Password, 1)
						
						SET @IdUsuario = SCOPE_IDENTITY()
						
						INSERT INTO UsuarioRol
						SELECT 
							@IdUsuario AS 'IdUsuario', 
							value AS 'IdRol',
							1 AS 'Activo'
						FROM STRING_SPLIT(@Roles,',')
						
						SELECT CONCAT('1|','El usuario se registró con éxito');

					END
					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN
					PRINT ERROR_MESSAGE();
					
					SELECT concat('0|',ERROR_MESSAGE());

					--SELECT concat('0|','Ha ocurrido un error al momento de registrar el usuario!');
				END CATCH
			          
			END
		
	END
	   
	   
	ELSE IF @nOpcion = 4  -- EDITAR   (U)                                                        
	BEGIN
		BEGIN
			SET @Correo				= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @PrimerNombre		= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @SegundoNombre		= (SELECT valor FROM @tParametro WHERE id = 3);
			SET @ApellidoPaterno	= (SELECT valor FROM @tParametro WHERE id = 4);
			SET @ApellidoMaterno	= (SELECT valor FROM @tParametro WHERE id = 5);
			SET @Roles				= (SELECT valor FROM @tParametro WHERE id = 6);			
			SET @Celular			= (SELECT valor FROM @tParametro WHERE id = 7);
			SET @IdUsuario			= (SELECT valor FROM @tParametro WHERE id = 8);
		END	


      BEGIN TRAN
				BEGIN TRY
					BEGIN
						
						BEGIN
							SET @IdPersona = (SELECT TOP 1 IdPersona FROM Usuario WHERE IdUsuario = @IdUsuario)
						END

						UPDATE Persona
						SET
							PrimerNombre = @PrimerNombre,
							SegundoNombre = @SegundoNombre,
							ApellidoPaterno = @ApellidoPaterno,
							ApellidoMaterno = @ApellidoMaterno,
							Celular = @Celular
						WHERE 
							IdPersona = @IdPersona

						UPDATE Usuario                           
						SET 
						   Correo = @Correo
				
						WHERE 
						   IdUsuario = @IdUsuario   
						   

						DELETE FROM UsuarioRol WHERE IdUsuario = @IdUsuario

						INSERT INTO UsuarioRol
						SELECT 
							@IdUsuario AS 'IdUsuario', 
							value AS 'IdRol',
							1 AS 'Activo'
						FROM STRING_SPLIT(@Roles,',')
		 
					SELECT CONCAT('1|','El usuario se actualizó con éxito');

					END
					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN
					PRINT ERROR_MESSAGE();					
					SELECT CONCAT('0|','Ha ocurrido un error al momento de actualizar el usuario!');
				END CATCH
										 
                                                       
	END;                            

                                                           
	ELSE IF @nOpcion = 5  -- ELIMINAR (D)                                                          
	BEGIN  
		BEGIN
			SET @IdUsuario	= (SELECT valor FROM @tParametro WHERE id = 1);	
			SET @Activo	= (SELECT valor FROM @tParametro WHERE id = 2);	
		END	

		BEGIN TRANSACTION
			BEGIN TRY
				BEGIN

					--Eliminacion Logica
					UPDATE Usuario
						SET	 Activo = @Activo
					WHERE 
						IdUsuario = @IdUsuario

					IF (@Activo = 0)
						BEGIN
							SELECT CONCAT('1|','El usuario se eliminó con éxito');
						END
					ELSE
						BEGIN
							SELECT CONCAT('1|','El usuario se activó con éxito');
						END

				END
			COMMIT TRAN
			END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			PRINT ERROR_MESSAGE();					
			SELECT CONCAT('0|','Ha ocurrido un error al momento de actualizar el usuario!');
		END CATCH
                                               
	END;                                                        
    
END
