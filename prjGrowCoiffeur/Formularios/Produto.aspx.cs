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
            CarregarProdutos();



        }

        private void CarregarProdutos()
        {
            string tipoUsuario = Session["TipoUsuario"] as string;

            try
            {
                Produtos produtos = new Produtos();
                List<clsProduto> lista_produtos = produtos.Listar();

                
                btnaddproduto.Visible = tipoUsuario != "funcionario";

                if (lista_produtos.Count > 0)
                {
                    string html = "<table class='table'><tr><th>Código</th><th>Nome</th><th>Marca</th>" +
                                  "<th>Preço</th><th>Data de Validade</th><th>Quantidade no Estoque</th>";

                    
                    if (tipoUsuario != "funcionario")
                    {
                        html += "<th>Ações</th>"; 
                    }
                    html += "</tr>";

                    foreach (var produto in lista_produtos)
                    {
                        html += $@"<tr>
                            <td class='alinhartabcentro'>{produto.CdProduto}</td>
                            <td>{produto.NmProduto ?? "N/A"}</td>
                            <td>{produto.NmMarcaProduto ?? "N/A"}</td>
                            <td class='alinhartabcentro'>{produto.VlProdutoEstoque.ToString("C")}</td>
                            <td class='alinhartabcentro'>{produto.DtValidadeProduto.ToString("dd/MM/yyyy")}</td>
                            <td class='alinhartabcentro'>{produto.QtProdutoEstoque}</td>";

                        
                        if (tipoUsuario != "funcionario")
                        {
                            html += $@"<td id='tdlinks'> 
                                <a href='editarProduto.aspx?c={produto.CdProduto}'>
                                    <img src='../images/editar.svg' class='imgtabela'/>
                                </a>
                            </td>";
                        }
                        html += "</tr>";
                    }
                    html += "</table>";
                    litProdutos.Text = html;
                }
                else
                {
                    litProdutos.Text = "<p>Nenhum produto encontrado.</p>";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Erro na listagem de produtos: " + ex.Message);
            }
        }


        protected void btnaddproduto_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdicionarProduto.aspx");
        }
    }
}
