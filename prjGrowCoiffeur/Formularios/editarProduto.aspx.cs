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
            int codigoProduto = int.Parse(txtCodigo.Text);
            string connectionString = "SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                // Call the stored procedure ExcluirProduto
                string query = "CALL ExcluirProduto(@cd_produto)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@cd_produto", codigoProduto);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        litMsg.Text = "<h2 class='sucesso'>Produto excluído com sucesso</h2>";
                        Response.Redirect("produto.aspx", false); // Redirecionar para produto.aspx
                        Context.ApplicationInstance.CompleteRequest(); // Completa a requisição
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
        }


        protected void btnedit_Click(object sender, EventArgs e)
        {
            #region Validações
            string textoPreco = txtPreco.Text.Replace("R$", "").Trim().Replace(".", ",");
            double preco;
            if (!double.TryParse(textoPreco, out preco))
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

            int codigoProduto = int.Parse(txtCodigo.Text);
            string connectionString = "SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                // Atualize a query para incluir a data de validade
                string query = "CALL AtualizarProduto(@cd_produto, @nm_produto, @nm_marca_produto, @vl_produto_estoque, @qt_produto_estoque, @dt_validade_produto)";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@cd_produto", codigoProduto);
                cmd.Parameters.AddWithValue("@nm_produto", txtNome.Text);
                cmd.Parameters.AddWithValue("@nm_marca_produto", txtmarca.Text);
                cmd.Parameters.AddWithValue("@vl_produto_estoque", preco);
                cmd.Parameters.AddWithValue("@qt_produto_estoque", quantidadeEstoque);
                cmd.Parameters.AddWithValue("@dt_validade_produto", dataValidade); // Adicione a data de validade

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        litMsg.Text = "<h2 class='sucesso'>Produto atualizado com sucesso</h2>";
                        Response.Redirect("produto.aspx", false); // Redirecionar para produto.aspx
                        Context.ApplicationInstance.CompleteRequest(); // Completa a requisição
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
}