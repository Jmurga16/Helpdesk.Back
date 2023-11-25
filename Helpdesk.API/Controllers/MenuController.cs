using Business;
using Entity;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Invitados.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MenuController : Controller
    {

        private readonly MenuBusiness objMenu = new MenuBusiness();

        private readonly Logger logger = LogManager.GetCurrentClassLogger();

        #region Menu

        [HttpPost]
        public IActionResult CrudMenu(GeneralEntity genEnt)
        {

            if (genEnt.nOpcion == 1 || genEnt.nOpcion == 2 || genEnt.nOpcion == 3)
            {
                try
                {
                    var vRes = objMenu.BusinessMenu(genEnt);

                    return Ok(vRes);
                }
                catch (Exception e)
                {

                    logger.Error(e);
                    throw;

                }
            }

            else if (genEnt.nOpcion == 4 || genEnt.nOpcion == 5 || genEnt.nOpcion == 6 || genEnt.nOpcion == 7)
            {
                try
                {
                    string[] listaRes;

                    string sResultado = Convert.ToString(objMenu.BusinessMenu(genEnt));
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
