using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarProduto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request["c"]))
            {
                Response.Redirect("index.aspx");
                return;
            }
            int codigoProduto = int.Parse(Request["c"].ToString());
            txtCodigo.Text = codigoProduto.ToString();
            if (!IsPostBack)
            {
                try
                {
                    Produtos produtos = new Produtos();
                    clsProduto produto = produtos.BuscarDadosProduto(codigoProduto);

                    if (produto != null)
                    {
                        txtCodigo.Text = codigoProduto.ToString();
                        txtNome.Text = produto.NmProduto;
                        txtmarca.Text = produto.NmMarcaProduto;


                        txtPreco.Text = produto.VlProdutoEstoque.ToString("C", System.Globalization.CultureInfo.CurrentCulture);


                        txtdata.Text = produto.DtValidadeProduto.ToString("yyyy-MM-dd");


                        txtquantidadenoestoque.Text = produto.QtProdutoEstoque.ToString();
                    }
                }
                catch
                {
                    Response.Redirect("erro.aspx");
                }
            }
        }

        protected void btnexcluir_Click(object sender, EventArgs e)
        {
            int codigoProduto = int.Parse(txtCodigo.Text);
            Produtos produtos = new Produtos();

            try
            {
                bool excluido = produtos.ExcluirProduto(codigoProduto);
                if (excluido)
                {
                    litMsg.Text = "<h2 class='sucesso'>Produto excluído com sucesso</h2>";
                    Response.Redirect("produto.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<h2 class='erro'>Erro ao excluir o produto. Produto não encontrado.</h2>";
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao excluir o produto: " + ex.Message + "</h2>";
            }
        }


        protected void btnedit_Click(object sender, EventArgs e)
        {
            #region Validações
            // Remover "R$" e formatar o preço corretamente
            string textoPreco = txtPreco.Text.Replace("R$", "").Trim().Replace(".", ",");
            decimal preco;
            // Tentar converter o texto em decimal
            if (!decimal.TryParse(textoPreco, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out preco))
            {
                litMsg.Text = "<h2 class='erro'>Preço inválido</h2>";
                return;
            }

            int quantidadeEstoque;
            if (!int.TryParse(txtquantidadenoestoque.Text, out quantidadeEstoque))
            {
                litMsg.Text = "<h2 class='erro'>Quantidade no estoque inválida</h2>";
                return;
            }

            DateTime dataValidade;
            if (!DateTime.TryParse(txtdata.Text, out dataValidade))
            {
                litMsg.Text = "<h2 class='erro'>Data de validade inválida</h2>";
                return;
            }
            #endregion

            clsProduto produto = new clsProduto(
                int.Parse(txtCodigo.Text),
                txtNome.Text,
                txtmarca.Text,
                dataValidade,
                quantidadeEstoque,
                preco 
            );

            Produtos produtos = new Produtos();

            try
            {
                bool atualizado = produtos.EditarProduto(produto);
                if (atualizado)
                {
                    litMsg.Text = "<h2 class='sucesso'>Produto atualizado com sucesso</h2>";
                    Response.Redirect("produto.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<h2 class='erro'>Erro ao atualizar o produto. Produto não encontrado.</h2>";
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao atualizar o produto: " + ex.Message + "</h2>";
            }
        }
    }
}
