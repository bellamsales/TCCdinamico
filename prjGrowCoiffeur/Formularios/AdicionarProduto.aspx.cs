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

                decimal preco;
                string precoFormatado = txtPreco.Text
                    .Replace("R$", "")
                    .Replace(" ", "")
                    .Replace(',', '.') 
                    .Trim();

                if (!decimal.TryParse(precoFormatado, out preco))
                {
                    litMsg.Text = "<p style='color: red;'>Preço inválido. Use o formato correto (ex: 40 ou 45.25).</p>";
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

                using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand("CALL InserirProduto(@Codigo, @Nome, @Preco, @Marca, @DataValidade, @Quantidade)", conn);

                   
                    if (string.IsNullOrWhiteSpace(txtCodigo.Text) || !int.TryParse(txtCodigo.Text, out int codigo))
                    {
                        litMsg.Text = "<p style='color: red;'>Código do produto inválido.</p>";
                        return;
                    }

                    cmd.Parameters.AddWithValue("@Codigo", codigo); 

                    cmd.Parameters.AddWithValue("@Nome", txtNome.Text);
                    cmd.Parameters.AddWithValue("@Preco", preco);
                    cmd.Parameters.AddWithValue("@Marca", txtMarca.Text);
                    cmd.Parameters.Add(new MySqlParameter("@DataValidade", MySqlDbType.Date) { Value = dataValidade }); 
                    cmd.Parameters.AddWithValue("@Quantidade", quantidade);

                    int resultado = cmd.ExecuteNonQuery();

                    if (resultado > 0)
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
            }
            catch (MySqlException mysqlEx)
            {
                litMsg.Text = $"<p style='color: red;'>Erro de MySQL: {mysqlEx.Number} - {mysqlEx.Message}</p>";
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