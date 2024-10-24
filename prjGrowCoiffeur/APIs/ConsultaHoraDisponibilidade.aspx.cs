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

            if (!DateTime.TryParse(dataStr, out DateTime data))
            {
                RespondWithError(400, "Data inválida");
                return;
            }

            GiFuncionarios giFuncionarios = new GiFuncionarios();
            List<string> horariosOcupados = giFuncionarios.ObterHorariosOcupados(funcionario, data);

            int duracao = 60; // Ou obtenha isso do request se necessário.

            // Obtenha os horários disponíveis
            var horariosDisponiveis = ObterHorariosDisponiveis(duracao, horariosOcupados);

            RespondWithJson(horariosDisponiveis);
        }

            private void RespondWithError(int statusCode, string message)
        {
            Response.StatusCode = statusCode;
            Response.Write($"{{\"error\":\"{message}\"}}");
        }

        private void RespondWithJson(object data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string dadosJSON = serializer.Serialize(data);
            Response.Write(dadosJSON);
        }

        public Dictionary<string, List<string>> ObterHorariosDisponiveis(int duracao, List<string> horariosOcupados)
        {

            var horariosDisponiveis = new Dictionary<string, List<string>>()
            {
                { "manha", new List<string>() },
                { "tarde", new List<string>() },
                { "noite", new List<string>() }
            };

            TimeSpan inicioManha = new TimeSpan(8, 0, 0);
            TimeSpan fimAlmoco = new TimeSpan(12, 0, 0);
            TimeSpan inicioTarde = new TimeSpan(13, 0, 0);
            TimeSpan fimTarde = new TimeSpan(17, 30, 0);
            TimeSpan inicioNoite = new TimeSpan(18, 0, 0);
            TimeSpan fimNoite = new TimeSpan(20, 0, 0);

            // Manhã
            for (TimeSpan hora = inicioManha; hora < fimAlmoco; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")))
                {
                    if ((duracao == 30 && hora + TimeSpan.FromMinutes(30) <= fimAlmoco) ||
                        (duracao == 60 && hora + TimeSpan.FromMinutes(60) <= fimAlmoco) ||
                        (duracao == 120 && hora + TimeSpan.FromMinutes(120) <= fimAlmoco))
                    {
                        horariosDisponiveis["manha"].Add($"<button class='horario-btn' onclick=\"selecionarHorario('{hora:hh\\:mm}')\">{hora:hh\\:mm}</button>");
                    }
                }
            }

            // Tarde
            for (TimeSpan hora = inicioTarde; hora < fimTarde; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")))
                {
                    horariosDisponiveis["tarde"].Add($"<button class='horario-btn' onclick=\"selecionarHorario('{hora:hh\\:mm}')\">{hora:hh\\:mm}</button>");
                }
            }

            foreach (var periodo in horariosDisponiveis)
            {
                Console.WriteLine($"Período: {periodo.Key}, Horários: {string.Join(", ", periodo.Value)}");
            }

            // Noite
            for (TimeSpan hora = inicioNoite; hora < fimNoite; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")))
                {
                    horariosDisponiveis["noite"].Add($"<button class='horario-btn' onclick=\"selecionarHorario('{hora:hh\\:mm}')\">{hora:hh\\:mm}</button>");
                }
            }

            return horariosDisponiveis;


        }
    }
}
