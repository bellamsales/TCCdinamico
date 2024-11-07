using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class ListarClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarClientes();
            }

        }

        private void CarregarClientes()
        {
            try
            {
                Clientes clientes = new Clientes();
                List<Cliente> lista_clientes = clientes.Listar();

                if (lista_clientes.Count > 0)
                {
              
                    string html = "<table class='table'><tr><th>Nome</th><th>Email</th><th>Endereço</th>" +
                        "<th>Descrição</th><th>Status</th><th>Ações</th></tr>"; 

                    foreach (var cliente in lista_clientes)
                    {
                        string descricao = cliente.Ativo ? cliente.Descricao :
                                   (clientes.ClienteTemAgendamentos(cliente.Email) ?
                                    "Cliente inativo pois possui próximos agendamentos" :
                                    "Cliente inativo");
                        string status = cliente.Ativo ? "Ativo" : "Inativo"; 
                        string acaoLink = cliente.Ativo ?
                            $"<a href='editarCliente.aspx?s={cliente.Email}'><img src='../images/editar.png' class='imgtabela'/></a>" :
                            "<span>Inativo</span>";

                        string rowClass = cliente.Ativo ? "" : "inativo";

                       
                        html += $@"<tr class='{rowClass}'>
                        <td class='alinhartabcentro'>{cliente.Nome}</td>
                        <td>{cliente.Email}</td>
                        <td>{cliente.Endereco}</td>
                        <td class='alinhartabcentro'>{descricao}</td>
                        <td class='alinhartabcentro'>{status}</td> 
                        <td id='tdlinks'>{acaoLink}</td>
                    </tr>";
                    }
                    html += "</table>";
                    litcliente.Text = html;
                }
                else
                {
                    litcliente.Text = "<p>Nenhum cliente encontrado.</p>";
                }
            }
            catch (Exception)
            {
                Response.Redirect("erro.aspx");
            }
        }

        protected void btnaddcliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdicionarCliente.aspx");
        }
    }
}