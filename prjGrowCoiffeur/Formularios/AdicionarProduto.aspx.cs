using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;


namespace prjGrowCoiffeur.Formularios
{
    public partial class AdicionarProduto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GerarCodigoProduto();
            }
        }

        private void GerarCodigoProduto()
        {
            int novoCodigo;
            using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT IFNULL(MAX(cd_produto), 0) + 1 FROM Produto", conn);
                novoCodigo = Convert.ToInt32(cmd.ExecuteScalar());

                
                
            }

            txtCodigo.Text = novoCodigo.ToString(); 
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtNome.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Nome' é obrigatório.</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtPreco.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Preço' é obrigatório.</p>";
                    return;
                }

                string textoPreco = txtPreco.Text.Replace("R$", "").Trim().Replace(".", ",");
                decimal preco;

                // Tentar converter texto para decimal
                if (!decimal.TryParse(textoPreco, NumberStyles.Any, new CultureInfo("pt-BR"), out preco))
                {
                    litMsg.Text = "<p style='color: red;'>Preço inválido. Use o formato correto (ex: 40 ou 45,25).</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtMarca.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Marca' é obrigatório.</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtdata.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Data de Validade' é obrigatório.</p>";
                    return;
                }

                string dataEntrada = txtdata.Text.Trim();

                if (!DateTime.TryParse(dataEntrada, out DateTime dataValidade))
                {
                    litMsg.Text = "<p style='color: red;'>Data de validade inválida. Formato esperado: dd/MM/yyyy.</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtquantidadenoestoque.Text) ||
                    !int.TryParse(txtquantidadenoestoque.Text, out int quantidade))
                {
                    litMsg.Text = "<p style='color: red;'>Quantidade em estoque inválida.</p>";
                    return;
                }

                Produtos produtos = new Produtos();
                clsProduto produto = new clsProduto(
                    int.Parse(txtCodigo.Text),
                    txtNome.Text,
                    txtMarca.Text,
                    dataValidade,
                    quantidade,
                    preco
                );

                bool produtoAdicionado = produtos.AdicionarProduto(produto);

                if (produtoAdicionado)
                {
                    litMsg.Text = "<p style='color: green;'>Produto adicionado com sucesso!</p>";
                    LimparCampos();
                    Response.Redirect("produto.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<p style='color: red;'>Erro ao adicionar o produto.</p>";
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = $"<p style='color: red;'>Erro: {ex.Message}</p>";
            }
        }

        private void LimparCampos()
        {
            txtCodigo.Text = string.Empty; 
            txtNome.Text = string.Empty;
            txtPreco.Text = string.Empty;
            txtMarca.Text = string.Empty;
            txtdata.Text = string.Empty;
            txtquantidadenoestoque.Text = string.Empty;

            GerarCodigoProduto(); 
        }
    }
}