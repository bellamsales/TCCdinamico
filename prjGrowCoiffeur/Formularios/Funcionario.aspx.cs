using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using prjGrowCoiffeur.Modelo;
using prjGrowCoiffeur.Logica;

namespace prjGrowCoiffeur.Formularios
{
	public partial class funcionario : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                
                string tipoUsuario = Session["TipoUsuario"] as string;
                if (tipoUsuario == "funcionario")
                {
                    
                    btnaddfuncionario.Visible = false;
                }

                CarregarFuncionarios();
            }
        }

        private void CarregarFuncionarios()
        {
            try
            {
                GiFuncionarios funcionarios = new GiFuncionarios();
                List<Funcionario> listafuncionarios = funcionarios.Listar();

                if (listafuncionarios != null && listafuncionarios.Count > 0)
                {
                    string tipoUsuario = Session["TipoUsuario"] as string;
                    bool éFuncionario = tipoUsuario == "funcionario";

                    string html = "<table class='table'><tr><th>Nome</th><th>Email</th><th>Telefone</th>" +
                                  "<th>Endereço</th><th>Cargo</th><th>Status</th>"; 

                    
                    if (!éFuncionario)
                    {
                        html += "<th>Descrição</th>"; 
                    }

                    if (!éFuncionario)
                    {
                        html += "<th>Ações</th>";
                    }

                    html += "</tr>";

                    foreach (var funcionario in listafuncionarios)
                    {
                        string status = funcionario.Ativo ? "Ativo" : "Inativo";
                        string descricao = funcionario.Ativo ?
                            "Funcionário ativo" : 
                            "Funcionário inativado pois possui agendamentos próximos"; 

                        string acaoLink = funcionario.Ativo ?
                            $"<a href='editarFuncionario.aspx?s={funcionario.Email}'><img src='../images/editar.svg' class='imgtabela'/></a>" :
                            "<span>Inativo</span>";

                        string rowClass = funcionario.Ativo ? "ativo" : "inativo";

                        html += $@"<tr class='{rowClass}'>
                            <td class='alinhartabcentro'>{funcionario.Nome}</td>
                            <td>{funcionario.Email}</td>
                            <td>{funcionario.Telefone}</td>
                            <td class='alinhartabcentro'>{funcionario.Endereco}</td>
                            <td class='alinhartabcentro'>{funcionario.Cargo}</td>
                            <td class='alinhartabcentro'>{status}</td>";

                        
                        if (!éFuncionario)
                        {
                            html += $"<td class='alinhartabcentro'>{descricao}</td>"; 
                        }

                        if (!éFuncionario)
                        {
                            html += $@"<td id='tdlinks'>{acaoLink}</td>";
                        }

                        html += "</tr>";
                    }
                    html += "</table>";
                    litfuncionario.Text = html;
                }
                else
                {
                    litfuncionario.Text = "<p>Nenhum funcionário encontrado.</p>";
                }
            }
            catch (Exception ex)
            {
                litfuncionario.Text = $"<p>Erro ao carregar funcionários: {ex.Message}</p>";
            }
        }

        protected void btnaddfuncionario_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdicionarFuncionario.aspx");
        }
    }
}