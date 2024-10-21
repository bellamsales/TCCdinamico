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
                CarregarFuncionarios();
            }
        }
        private void CarregarFuncionarios()
        {
            GiFuncionarios giFuncionarios = new GiFuncionarios();
            //List<Funcionario> funcionarios = giFuncionarios.ConsultarFuncionarios();

            ddlFuncionarios.Items.Clear();
            ddlFuncionarios.Items.Add(new ListItem("Selecionar Funcionário", "-1"));

            //foreach (Funcionario funcionario in funcionarios)
            //{
            //    ddlFuncionarios.Items.Add(new ListItem(funcionario.Nome, funcionario.Email));
            //}

        }

        protected void ddlFuncionarios_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        protected void txtDataAgendamento_TextChanged(object sender, EventArgs e)
        {
            string emailFuncionario = ddlFuncionarios.SelectedValue;
            DateTime dataAgendamento;
            if (!DateTime.TryParse(txtDataAgendamento.Text, out dataAgendamento))
            {
                return; 
            }
            PreencherAgendamentos(dataAgendamento, emailFuncionario);
        }
    }
}