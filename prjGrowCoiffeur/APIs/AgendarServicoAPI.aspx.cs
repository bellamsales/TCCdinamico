using prjGrowCoiffeur.Logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.APIs
{
    public partial class AgendarServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "application/json";

            string funcionario = Request.QueryString["funcionario"];
            string dataStr = Request.QueryString["data"];
            string periodo = Request.QueryString["periodo"];
            string cliente = Request.QueryString["cliente"];
            string servicoStr = Request.QueryString["servico"];
            string horaStr = Request.QueryString["hora"];

            DateTime data;
            if (!DateTime.TryParse(dataStr, out data))
            {
                Response.StatusCode = 400;
                Response.Write("{\"error\":\"Data inválida\"}");
                return;
            }

            TimeSpan hora;
            if (!TimeSpan.TryParse(horaStr, out hora))
            {
                Response.StatusCode = 400;
                Response.Write("{\"error\":\"Hora inválida\"}");
                return;
            }
            int servico;
            if (!int.TryParse(servicoStr, out servico))
            {
                Response.StatusCode = 400;
                Response.Write("{\"error\":\"Serviço inválido\"}");
                return;
            }

            GiServico giServico = new GiServico();


            bool agendado = giServico.AgendarServico(cliente, servico, hora, data, funcionario);


            if (agendado)
            {
                Response.Write($"{{\"success\":true,\"message\":\"Agendamento realizado com sucesso para {cliente}\", \"servico\":\"{servicoStr}\", \"data\":\"{data:dd/MM/yyyy}\", \"hora\":\"{hora}\", \"funcionario\":\"{funcionario}\"}}");
            }
            else
            {
                Response.StatusCode = 500;
                Response.Write("{\"success\":false,\"error\":\"Ocorreu um erro ao tentar agendar o serviço. Tente novamente mais tarde.\"}");
            }
        }

    }
}