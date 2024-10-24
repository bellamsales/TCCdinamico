using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace prjGrowCoiffeur.Formularios
{
    public partial class Agendar : System.Web.UI.Page
    {
        public Cliente Cliente { get; set; }
        public Funcionario Funcionario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TipoUsuario"] == null)
            {
                
                Response.Redirect("Login.aspx");
                return; 
            }

            
            if (Session["TipoUsuario"].ToString() == "funcionario")
            {
                pnlCliente.Visible = true;
                Cliente cliente = new Cliente();
                cliente.Email = txtCliente.Text.Trim().ToLower();
                this.Cliente = cliente;
            }
            else
            {
                Cliente cliente = new Cliente();
                cliente.Email = Session["EmailUsuario"].ToString();
                pnlCliente.Visible = false;
                this.Cliente = cliente;
            }


            GiCategoria categorias = new GiCategoria();
            if (!IsPostBack)
            {
                ddlcategoriaServico.Items.Add(new ListItem("Selecionar Categoria", "-1"));
                ddlservico.Items.Add(new ListItem("Selecionar Serviço", "-1"));
                ddlprofissional.Items.Add("Selecionar Profissional");
                cmbMeses.Enabled = false;
                ddlprofissional.Enabled = false;
                ddlservico.Enabled = false;
                GerarMeses();

                foreach (Categoria categoria in categorias.ConsultarCategorias())
                {
                    ddlcategoriaServico.Items.Add(new ListItem(categoria.Nome, categoria.Codigo.ToString()));
                }
            }

            int currentMonth = DateTime.Now.Month;
            int currentYear = DateTime.Now.Year;


        }

        private void GerarMeses()
        {

            cmbMeses.Items.Add(new ListItem("Outubro", "10"));
            cmbMeses.Items.Add(new ListItem("Novembro", "11"));
            cmbMeses.Items.Add(new ListItem("Dezembro", "12"));
        }

        protected void ddlservico_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlservico.Enabled = true;
            //ddlservico.Items.Clear();
            //ddlservico.Items.Add(new ListItem("Selecionar Serviço", "-1"));
            //GiServico servicos = new GiServico();
            //if (ddlcategoriaServico.SelectedValue != "-1")
            //    foreach (Servico servico in servicos.ConsultarServicosPorCategoria(int.Parse(ddlcategoriaServico.SelectedValue)))
            //    {

            //        ddlservico.Items.Add(new ListItem(servico.Nome, servico.Codigo.ToString()));
            //    }

        }

        protected void ddlservico_SelectedIndexChanged1(object sender, EventArgs e)
        {
            litDias.Text = "";
            ddlprofissional.Enabled = true;
            ddlprofissional.Items.Clear();

            GiFuncionarios funcionarios = new GiFuncionarios();
            if (ddlservico.SelectedValue != "-1")
                foreach (Modelo.Funcionario funcionario in funcionarios.ConsultarFuncionariosPorServico(int.Parse(ddlservico.SelectedValue)))
                {
                    ddlprofissional.Items.Add(new ListItem(funcionario.Nome, funcionario.Email.ToString()));
                }
            cmbMeses.Enabled = true;
        }

        protected void cmbMeses_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlprofissional.SelectedValue != "-1")
            {
                GerarDiasDisponiveis();
            }

        }

        private void GerarDiasDisponiveis()
        {
            GiFuncionarios giFuncionarios = new GiFuncionarios();
            var diasDisponiveis = giFuncionarios.ConsultarDisponibilidadeFuncionario(ddlprofissional.SelectedValue)
                .Where(d => d.Data.Month == int.Parse(cmbMeses.SelectedValue))
                .Select(d => d.Data.Day)
                .ToList();

            DateTime primeiroDiaDoMes = new DateTime(DateTime.Now.Year, int.Parse(cmbMeses.SelectedValue), 1);
            int totalDiasNoMes = DateTime.DaysInMonth(DateTime.Now.Year, int.Parse(cmbMeses.SelectedValue));

            litDias.Text = string.Join("", Enumerable.Range(1, totalDiasNoMes).Select(dia =>
            {
                DateTime dataAtual = primeiroDiaDoMes.AddDays(dia - 1);
                bool isDisponivel = diasDisponiveis.Contains(dia);
                return $"<div class=\"{(isDisponivel ? "dia predefinido" : "dia indisponivel")}\" onclick=\"handleDiaClick({dia}, '{ddlprofissional.SelectedValue}', {cmbMeses.SelectedValue}, '{ddlservico.SelectedValue}', '{Cliente.Email}')\">{dia}</div>";
            }));

            Console.WriteLine("Dias Disponíveis para Outubro: " + string.Join(", ", diasDisponiveis));
        }
    }
}

