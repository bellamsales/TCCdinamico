using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// Gereciamento Interno

namespace prjGrowCoiffeur.Formularios
{
    public partial class Agendar : System.Web.UI.Page
    {
        public Cliente Cliente { get; set; }
        public Funcionario Funcionario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
           if (Session["TipoUsuario"] != null && Session["TipoUsuario"].ToString() == "funcionario")
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

        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlservico.Items.Clear();
            ddlservico.Items.Add(new ListItem("Selecionar Serviço", "-1"));
            ddlservico.Enabled = false;
            ddlprofissional.Items.Clear();
            ddlprofissional.Items.Add(new ListItem("Selecionar Profissional", "-1"));
            ddlprofissional.Enabled = false; 

            if (ddlcategoriaServico.SelectedValue != "-1")
            {
                GiServico servicos = new GiServico();
                var servicosPorCategoria = servicos.ConsultarServicosPorCategoria(int.Parse(ddlcategoriaServico.SelectedValue));

                if (servicosPorCategoria.Count > 0)
                {
                    foreach (Servico servico in servicosPorCategoria)
                    {
                        ddlservico.Items.Add(new ListItem(servico.Nome, servico.Codigo.ToString()));
                    }
                    ddlservico.Enabled = true;
                }

                
                GiFuncionarios funcionarios = new GiFuncionarios();
                var funcionariosPorCategoria = funcionarios.ConsultarFuncionariosPorCategoria(int.Parse(ddlcategoriaServico.SelectedValue));

                if (funcionariosPorCategoria.Count > 0)
                {
                    foreach (Modelo.Funcionario funcionario in funcionariosPorCategoria)
                    {
                        ddlprofissional.Items.Add(new ListItem(funcionario.Nome, funcionario.Email.ToString()));
                    }
                    ddlprofissional.Enabled = true; 
                }
            }

            cmbMeses.Enabled = true;
        }

            protected void ddlservico_SelectedIndexChanged1(object sender, EventArgs e)
        {
            litDias.Text = "";
            ddlprofissional.Items.Clear(); 
            ddlprofissional.Items.Add(new ListItem("Selecionar Profissional", "-1")); 
            ddlprofissional.Enabled = false; 

            GiFuncionarios funcionarios = new GiFuncionarios();
            GiServico servicos = new GiServico();
            GiCategoria categorias = new GiCategoria(); 

            if (ddlservico.SelectedValue != "-1")
            {
                
                var funcionariosPorServico = funcionarios.ConsultarFuncionariosPorServico(int.Parse(ddlservico.SelectedValue));

                if (funcionariosPorServico.Count > 0)
                {
                    foreach (Modelo.Funcionario funcionario in funcionariosPorServico)
                    {
                        ddlprofissional.Items.Add(new ListItem(funcionario.Nome, funcionario.Email.ToString()));
                    }
                    ddlprofissional.Enabled = true;
                }

               
                Categoria categoria = categorias.ConsultarCategoriaPorServico(int.Parse(ddlservico.SelectedValue)); 
                if (categoria != null)
                {
                    var funcionariosPorCategoria = funcionarios.ConsultarFuncionariosPorCategoria(categoria.Codigo);

                    foreach (Modelo.Funcionario funcionario in funcionariosPorCategoria)
                    {
                        if (!ddlprofissional.Items.Cast<ListItem>().Any(item => item.Value == funcionario.Email))
                        {
                            ddlprofissional.Items.Add(new ListItem(funcionario.Nome, funcionario.Email.ToString()));
                        }
                    }
                }

               
                if (ddlprofissional.Items.Count > 1) 
                {
                    ddlprofissional.Enabled = true; 
                }
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
        }
    }
}

    