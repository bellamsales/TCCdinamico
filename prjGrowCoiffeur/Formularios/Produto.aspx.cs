using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur
{
    public partial class Produto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarProdutos();
            }
        }

        private void CarregarProdutos()
        {
            try
            {
                Produtos produtos = new Produtos();
                List<clsProduto> lista_produtos = produtos.Listar();

                if (lista_produtos.Count > 0)
                {
                    string html = "<table class='table'><tr><th>Código</th><th>Nome</th><th>Marca</th>" +
                        "<th>Preço</th><th></th></tr>";

                    foreach (var produto in lista_produtos)
                    {
                        html += $@"<tr>
                                    <td class='alinhartabcentro'>{produto.CdProduto}</td>
                                    <td>{produto.NmProduto}</td>
                                    <td>{produto.NmMarcaProduto}</td>
                                    <td class='alinhartabcentro'>{produto.VlProdutoEstoque.ToString("C")}</td>
                                    <td id='tdlinks'> 
                                   <a href='editarproduto.html'>
                                        <img src='../images/editar.svg' class='imgtabela'/>
                                    </a>
                                   
                                    <a href='excluirproduto.html'>
                                        <img src='../images/lixo.png' class='imgtabela'/>
                                    </a>
                                    </td>
                                </tr>";
                    }
                    html += "</table>";
                    litProdutos.Text = html;
                }
                else
                {
                    litProdutos.Text = "<p>Nenhum produto encontrado.</p>";
                }
            }
            catch (Exception)
            {
                Response.Redirect("erro.html");
            }
        }

        protected void btnaddproduto_Click(object sender, EventArgs e)
        {

        }
    }
}
