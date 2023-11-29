using Entity;
using NLog;
using System.Data;

namespace Data
{
    public class UsuarioData
    {
        private readonly Logger logger = LogManager.GetCurrentClassLogger();
        #region Conexion
        private readonly Conexion oCon;
        public UsuarioData()
        {
            oCon = new Conexion(1);
        }
        #endregion

        #region Usuario
        public object DataUsuario(GeneralEntity genEnt)
        {

            string msj = string.Empty;

            switch (genEnt.nOpcion)
            {
                #region 1. Lista de Usuarios
                case 1:
                    try
                    {
                        List<ListUsuarioEntity> listaUsuarios = new List<ListUsuarioEntity>();
                        using (IDataReader dr = oCon.ejecutarDataReader("USP_LISTAR_USUARIOS", genEnt.nOpcion, genEnt.pParametro))
                        {
                            while (dr.Read())
                            {
                                ListUsuarioEntity entity = new ListUsuarioEntity();


                                entity.IdUsuario = Int32.Parse(Convert.ToString(dr["IdUsuario"]));
                                entity.Nombres = Convert.ToString(dr["Nombres"]);
                                entity.Correo = Convert.ToString(dr["Correo"]);
                                entity.Rol = Convert.ToString(dr["Rol"]);
                                entity.Activo = Boolean.Parse(Convert.ToString(dr["Activo"]));

                                listaUsuarios.Add(entity);

                            }

                            return listaUsuarios;
                        }
                    }
                    catch (Exception e)
                    {
                        logger.Error(e);
                        throw;
                    }
                #endregion

                #region 2. Lista de Usuario Por Id
                case 2:
                    try
                    {
                        
                        UsuarioPorIdEntity entity = new UsuarioPorIdEntity();
                        List<RolEntity> rolEntity = new List<RolEntity>();

                        using (IDataReader dr = oCon.ejecutarDataReader("USP_LISTAR_USUARIOS", genEnt.nOpcion, genEnt.pParametro))
                        {

                            while (dr.Read())
                            {
                                                                
                                entity.IdUsuario = Int32.Parse(Convert.ToString(dr["IdUsuario"]));
                                entity.PrimerNombre = Convert.ToString(dr["PrimerNombre"]);
                                entity.SegundoNombre = Convert.ToString(dr["SegundoNombre"]);
                                entity.ApellidoPaterno = Convert.ToString(dr["ApellidoPaterno"]);
                                entity.ApellidoMaterno = Convert.ToString(dr["ApellidoMaterno"]);
                                entity.Celular = Convert.ToString(dr["Celular"]);
                                entity.Correo = Convert.ToString(dr["Correo"]);
                                
                                entity.Activo = Boolean.Parse(Convert.ToString(dr["Activo"]));

                            }

                            return entity;
                        }
                    }
                    catch (Exception e)
                    {
                        logger.Error(e);
                        throw;
                    }
                #endregion

                #region 3. Insertar | 4. Actualizar | 5. Eliminar(Logica) -- Clientes | Ingresar    
                case 3:
                case 4:
                case 5:
                case 6:

                    try
                    {
                        string sResultado = Convert.ToString(oCon.EjecutarEscalar("USP_MNT_Usuarios", genEnt.nOpcion, genEnt.pParametro));

                        msj = sResultado;
                    }
                    catch (Exception ex)
                    {
                        msj = ex.Message;
                    }
                    return msj;
                #endregion

                default:
                    return null;

            }
        }
    #endregion
}
}
