using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class Agendamentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tipoUsuario = (string)Session["TipoUsuario"];
                string funcionarioLogado = (string)Session["EmailUsuario"];

                if (string.IsNullOrEmpty(funcionarioLogado))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                if (tipoUsuario == "funcionario")
                {
                    
                    ddlFuncionarios.Visible = false;
                    DateTime dataAtual = DateTime.Now;
                    if (!string.IsNullOrEmpty(txtDataAgendamento.Text))
                    {
                        DateTime.TryParse(txtDataAgendamento.Text, out dataAtual);
                    }
                    PreencherAgendamentos(dataAtual, funcionarioLogado);
                }
                else if (tipoUsuario == "gerente")
                {
                  
                    ddlFuncionarios.Visible = true;
                    CarregarFuncionarios();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

                if (string.IsNullOrEmpty(txtDataAgendamento.Text))
                {
                    txtDataAgendamento.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
        }
        private void CarregarFuncionarios()
        {
            GiFuncionarios giFuncionarios = new GiFuncionarios();
            List<Funcionario> funcionarios = giFuncionarios.ConsultarFuncionarios();

            ddlFuncionarios.Items.Clear();
            ddlFuncionarios.Items.Add(new ListItem("Geral", "geral")); 

            foreach (Funcionario funcionario in funcionarios)
            {
                ddlFuncionarios.Items.Add(new ListItem(funcionario.Nome, funcionario.Email));
            }
        }

        private void CarregarAgendamentosFuncionario(string emailFuncionario)
        {
            
            DateTime dataAgendamento = DateTime.Now;
            PreencherAgendamentos(dataAgendamento, emailFuncionario);
        }


        protected void ddlFuncionarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tipoUsuario = (string)Session["TipoUsuario"];

            if (tipoUsuario != "gerente")
                return;

            string emailFuncionario = ddlFuncionarios.SelectedValue;
            DateTime dataAgendamento;

            if (!DateTime.TryParse(txtDataAgendamento.Text, out dataAgendamento))
            {
                dataAgendamento = DateTime.Now;
            }

            if (emailFuncionario == "geral")
            {
                PreencherAgendamentosGeral(dataAgendamento);
            }
            else
            {
                PreencherAgendamentos(dataAgendamento, emailFuncionario);
            }
        }
        protected void PreencherAgendamentos(DateTime dataAgendamento, string emailFuncionario)
        {
            List<Agendamento> agendamentos = new GiAgenda().ConsultarAgendamentosPorFuncionarioData(emailFuncionario, dataAgendamento);

            List<string> horarios = new List<string>()
            {
                "08:00", "08:30", "09:00", "09:30", "10:00", "10:30",
                "11:00", "11:30", "13:00", "13:30", "14:00", "14:30",
                "15:00", "15:30", "16:00", "16:30", "17:00", "17:30",
                "18:00", "18:30", "19:00", "19:30", "20:00"
            };

            StringBuilder htmlCompromissos = new StringBuilder();

            foreach (var horario in horarios)
            {
                Agendamento agendamento = agendamentos
                    .FirstOrDefault(a => a.HoraAgendamento.ToString(@"hh\:mm") == horario);

                if (agendamento != null)
                {
                    htmlCompromissos.Append($@"
                <div class='compromisso'>
                    {agendamento.Servico.Nome} - {agendamento.Cliente.Nome}
                </div>");
                }
                else
                {
                    htmlCompromissos.Append("<div class='compromisso-vazio'></div>");
                }
            }


        litCompromissos.Text = htmlCompromissos.ToString();
        }

        protected void PreencherAgendamentosGeral(DateTime dataAgendamento)
        {
            
                List<Agendamento> agendamentos = new GiAgenda().ConsultarAgendamentosPorData(dataAgendamento);

                List<string> horarios = new List<string>()
    {
        "08:00", "08:30", "09:00", "09:30", "10:00", "10:30",
        "11:00", "11:30", "13:00", "13:30", "14:00", "14:30",
        "15:00", "15:30", "16:00", "16:30", "17:00", "17:30",
        "18:00", "18:30", "19:00", "19:30", "20:00"
    };

                StringBuilder htmlCompromissos = new StringBuilder();

                foreach (var horario in horarios)
                {
                    TimeSpan horaComparacao = TimeSpan.Parse(horario);
                    var agendamentosNoHorario = agendamentos
                        .Where(a => a.HoraAgendamento == horaComparacao)
                        .ToList();

                    if (agendamentosNoHorario.Any())
                    {
                        foreach (var agendamento in agendamentosNoHorario)
                        {
                            htmlCompromissos.Append($@"
                    <div class='compromisso'>
                        {agendamento.Funcionario.Nome} - {agendamento.Servico.Nome} - {agendamento.Cliente.Nome}
                    </div>");
                        }
                    }
                    else
                    {
                        htmlCompromissos.Append("<div class='compromisso-vazio'></div>");
                    }
                }

                litCompromissos.Text = htmlCompromissos.ToString();
            }
        
            

            protected void txtDataAgendamento_TextChanged(object sender, EventArgs e)
        {
            string tipoUsuario = (string)Session["TipoUsuario"];
            string funcionarioLogado = (string)Session["EmailUsuario"];
            DateTime dataAgendamento;

            if (!DateTime.TryParse(txtDataAgendamento.Text, out dataAgendamento))
            {
                return;
            }

            if (tipoUsuario == "funcionario")
            {
                // Se for funcionário, sempre mostra apenas seus agendamentos
                PreencherAgendamentos(dataAgendamento, funcionarioLogado);
            }
            else if (tipoUsuario == "gerente")
            {
                // Se for gerente, verifica a seleção do DropDownList
                string emailFuncionario = ddlFuncionarios.SelectedValue;
                if (emailFuncionario == "geral")
                {
                    PreencherAgendamentosGeral(dataAgendamento);
                }
                else
                {
                    PreencherAgendamentos(dataAgendamento, emailFuncionario);
                }
            }
        }
    }
}