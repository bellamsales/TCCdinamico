using Newtonsoft.Json;
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
            string codigoServicoStr = Request.QueryString["codigoServico"];

            DateTime data;
            int codigoServico;

            if (!DateTime.TryParse(dataStr, out data))
            {
                Response.StatusCode = 400; // Bad Request
                Response.Write("{\"error\":\"Data inválida\"}");
                return;
            }

            if (!int.TryParse(codigoServicoStr, out codigoServico))
            {
                Response.StatusCode = 400; // Bad Request
                Response.Write("{\"error\":\"Código do serviço inválido\"}");
                return;
            }

            GiAgenda giAgenda = new GiAgenda();
            List<Disponibilidade> disponibilidades = giAgenda.FiltrarHorariosDisponiveis(funcionario, data, periodo, codigoServico);
            string dadosJSON;
            if (disponibilidades.Count > 0)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                dadosJSON = serializer.Serialize(disponibilidades);
                Response.Write(dadosJSON);
            }
            else
            {
                Response.StatusCode = 404; // Not Found
                Response.Write("{\"message\":\"Nenhuma disponibilidade encontrada\"}");
            }
        }
    }
}
