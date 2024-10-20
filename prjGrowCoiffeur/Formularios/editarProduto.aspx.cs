using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarProduto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request["c"]))
            {
                Response.Redirect("index.aspx");
                return;
            }
            int codigoProduto = int.Parse(Request["c"].ToString());
        }
    }
}