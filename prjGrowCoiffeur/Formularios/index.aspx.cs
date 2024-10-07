using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class inedx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnagendar_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }

    }
}