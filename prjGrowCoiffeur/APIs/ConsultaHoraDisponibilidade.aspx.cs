using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.APIs
{
    public partial class ConsultaHoraDisponibilidade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "application/json";

            string funcionario = Request.QueryString["funcionario"];
            string dataStr = Request.QueryString["data"];
            string periodo = Request.QueryString["periodo"];

            DateTime data;
            if (!DateTime.TryParse(dataStr, out data))
            {
                Response.StatusCode = 400; // Bad Request
                Response.Write("{\"error\":\"Data inválida\"}");
                return;
            }
            GiFuncionarios giFuncionarios = new GiFuncionarios();

            List<Disponibilidade> disponibilidades = giFuncionarios.ConsultarHoraDisponibilidadeFuncionario(funcionario, data, periodo);

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string dadosJSON = serializer.Serialize(disponibilidades);

            Response.Write(dadosJSON);
        }
    }
}