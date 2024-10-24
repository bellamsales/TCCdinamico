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
                List<Cliente> lista_produtos = clientes.Listar();

                if (lista_produtos.Count > 0)
                {
                    string html = "<table class='table'><tr><th>Email</th><th>Nome</th><th>Endereço</th>" +
                        "<th>Descrição</th><th></th></tr>";

                    foreach (var cliente in lista_produtos)
                    {
                        html += $@"<tr>
                                    <td class='alinhartabcentro'>{cliente.Email}</td>
                                    <td>{cliente.Nome}</td>
                                    <td>{cliente.Endereco}</td>
                                    <td class='alinhartabcentro'>{cliente.Descricao}</td>
                                    <td id='tdlinks'> 
                                   <a href='editarCliente.aspx?s={cliente.Email}'>
                                        <img src='../images/editar.svg' class='imgtabela'/>
                                    </a>
                                    </td>
                                </tr>";
                    }
                    html += "</table>";
                    litcliente.Text = html;
                }
                else
                {
                    litcliente.Text = "<p>Nenhum produto encontrado.</p>";
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