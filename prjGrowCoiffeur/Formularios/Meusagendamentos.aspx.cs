using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class Meusagendamentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TipoUsuario"] != null && Session["EmailUsuario"] != null)
            {
                string tipoUsuario = Session["TipoUsuario"].ToString();
                string emailUsuario = Session["EmailUsuario"].ToString();
                if (tipoUsuario == "funcionario")
                {
                    Response.Redirect("Login.aspx");
                }
                if (tipoUsuario == "gerente")
                {
                    Response.Redirect("Login.aspx");
                }


               
            }

           CarregarAgendamentos();
        }

        private void CarregarAgendamentos()
        {
            try
            {
                string emailCliente = GetEmailCliente();
                cliagenda agendamentosService = new cliagenda();
                List<Agendamento> listaAgendamentos = agendamentosService.ConsultarAgendamentosPorCliente(emailCliente);

                if (listaAgendamentos != null && listaAgendamentos.Count > 0)
                {
                    string html = "<table class='table'><tr><th>Data</th><th>Hora</th>" +
                                  "<th>Funcionário</th><th>Serviço</th></tr>";

                    foreach (var agendamento in listaAgendamentos)
                    {
                        // Verifique se as propriedades são válidas
                        string funcionarioNome = agendamento.Funcionario?.Nome ?? "Nome não disponível";
                        string servicoNome = agendamento.Servico?.Nome ?? "Serviço não disponível";

                        // Formatação da hora
                        string horaFormatada = $"{agendamento.HoraAgendamento.Hours:D2}:{agendamento.HoraAgendamento.Minutes:D2}";

                        html += $@"<tr>
                          
                            <td>{agendamento.DataAgendamento:dd/MM/yyyy}</td>
                            <td>{horaFormatada}</td>
                            <td class='alinhartabcentro'>{funcionarioNome}</td>
                            <td class='alinhartabcentro'>{servicoNome}</td>
                           </tr>";
                    }
                    html += "</table>";
                    litAgendamentos.Text = html;
                }
                else
                {
                    litAgendamentos.Text = "<p>Nenhum agendamento encontrado.</p>";
                }
            }
            catch (FormatException formatEx)
            {
                litAgendamentos.Text = $"<p>Erro de formatação: {formatEx.Message}</p>";
            }
            catch (Exception ex)
            {
                litAgendamentos.Text = $"<p>Erro ao carregar agendamentos: {ex.Message}</p>";
            }
        }
        private string GetEmailCliente()
        {

            return Session["EmailUsuario"]?.ToString() ?? string.Empty;
        }
    }
}