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
            string cliente = Request.QueryString["cliente"];
            string servicoStr = Request.QueryString["servico"];
            string horaStr = Request.QueryString["hora"];

            // Validação dos parâmetros
            if (string.IsNullOrEmpty(funcionario) ||
                string.IsNullOrEmpty(cliente) ||
                string.IsNullOrEmpty(servicoStr) ||
                string.IsNullOrEmpty(dataStr) ||
                string.IsNullOrEmpty(horaStr))
            {
                RespondWithError(400, "Todos os parâmetros devem ser fornecidos.");
                return;
            }

            if (!DateTime.TryParse(dataStr, out DateTime data))
            {
                RespondWithError(400, "Data inválida.");
                return;
            }

            if (!TimeSpan.TryParse(horaStr, out TimeSpan hora))
            {
                RespondWithError(400, "Hora inválida.");
                return;
            }

            if (!int.TryParse(servicoStr, out int servico))
            {
                RespondWithError(400, "Serviço inválido.");
                return;
            }

            GiServico giServico = new GiServico();
            try
            {
                bool agendado = giServico.AgendarServico(cliente, servico, hora, data, funcionario);

                if (agendado)
                {
                    RespondWithSuccess(cliente, servicoStr, data, hora, funcionario);
                }
                else
                {
                    RespondWithError(400, "Horário não disponível. Tente novamente.");
                }
            }
            catch (Exception ex)
            {
                RespondWithError(500, $"Erro ao agendar o serviço: {ex.Message}");
            }
        }

        private void RespondWithSuccess(string cliente, string servicoStr, DateTime data, TimeSpan hora, string funcionario)
        {
            var response = new
            {
                success = true,
                message = $"Agendamento realizado com sucesso para {cliente}.",
                servico = servicoStr,
                data = data.ToString("dd/MM/yyyy"),
                hora = hora.ToString(@"hh\:mm"),
                funcionario
            };

            Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(response));
        }

        private void RespondWithError(int statusCode, string message)
        {
            Response.StatusCode = statusCode;
            var errorResponse = new
            {
                error = message
            };
            Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(errorResponse));
        }
    }
}