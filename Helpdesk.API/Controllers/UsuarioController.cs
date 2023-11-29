using Business;
using Entity;
using Microsoft.AspNetCore.Mvc;
using NLog;

namespace Helpdesk.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly UsuarioBusiness objUsuario = new UsuarioBusiness();

        private readonly Logger logger = LogManager.GetCurrentClassLogger();

        #region Usuario

        [HttpPost]
        public IActionResult CrudUsuario(GeneralEntity genEnt)
        {

            if (genEnt.nOpcion == 1 || genEnt.nOpcion == 2)
            {
                try
                {
                    var vRes = objUsuario.BusinessUsuario(genEnt);

                    return Ok(vRes);
                }
                catch (Exception e)
                {

                    logger.Error(e);
                    throw;

                }
            }

            else if (genEnt.nOpcion == 3 || genEnt.nOpcion == 4 || genEnt.nOpcion == 5 || genEnt.nOpcion == 6)
            {
                try
                {
                    string[] listaRes;

                    string sResultado = Convert.ToString(objUsuario.BusinessUsuario(genEnt));
                    listaRes = sResultado.Split('|');

                    return Ok(new { cod = listaRes[0], mensaje = listaRes[1] });
                }
                catch (Exception e)
                {

                    logger.Error(e);
                    throw;

                }
            }

            else
            {
                return null;
            }

        }

        #endregion
    }
}
