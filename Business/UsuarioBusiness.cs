using Data;
using Entity;
using NLog;

namespace Business
{
    public class UsuarioBusiness
    {
        private readonly UsuarioData UsuarioData = new UsuarioData();
        private readonly Logger logger = LogManager.GetCurrentClassLogger();

        public object BusinessUsuario(GeneralEntity genEnt)
        {
            try
            {

                return UsuarioData.DataUsuario(genEnt);

            }
            catch (Exception e)
            {
                logger.Error(e);
                throw;

            }
        }
    }
}
