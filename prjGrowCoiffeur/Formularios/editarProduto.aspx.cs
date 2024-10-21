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

                        // Para preço, use "C" para valores decimais
                        txtPreco.Text = produto.VlProdutoEstoque.ToString("C", System.Globalization.CultureInfo.CurrentCulture);

                        // Para a data, use um formato adequado para datetime
                        txtdata.Text = produto.DtValidadeProduto.ToString("yyyy-MM-dd"); // ou "d", dependendo do formato desejado

                        // Para quantidade, se é um inteiro, não use "C"
                        txtquantidadenoestoque.Text = produto.QtProdutoEstoque.ToString();
                    }
                }
                catch
                {
                    Response.Redirect("erro.html");
                }
            }
        }

        protected void btnexcluir_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            #region Validações
            string textoPreco = "";
            double preco = 0.0;

            if (String.IsNullOrEmpty(txtNome.Text))
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Nome é obrigatório</h2>";
                txtNome.Focus();
                return;
            }
            if (String.IsNullOrEmpty(txtmarca.Text))
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Marca é obrigatório</h2>";
                txtmarca.Focus();
                return;
            }
            if (String.IsNullOrEmpty(txtquantidadenoestoque.Text))
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Marca é obrigatório</h2>";
                txtquantidadenoestoque.Focus();
                return;
            }
            if (String.IsNullOrEmpty(txtdata.Text))
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Marca é obrigatório</h2>";
                txtdata.Focus();
                return;
            }

            if (String.IsNullOrEmpty(txtPreco.Text))
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Preço é obrigatório</h2>";
                txtPreco.Focus();
                return;
            }

            textoPreco = txtPreco.Text.Replace("R$", "").Trim().Replace(".", ",");
            try
            {
                preco = double.Parse(textoPreco);
            }
            catch
            {
                litMsg.Text = $@"<h2 class='aviso erro'>Preço Inválido</h2>";
                txtPreco.Focus();
                return;
            }
            #endregion

        }
    }
}