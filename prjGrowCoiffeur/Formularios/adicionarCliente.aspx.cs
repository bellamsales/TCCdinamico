using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class adicionarCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnsalvar_Click(object sender, EventArgs e)
        {
            try
            {


                if (string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Email' é obrigatório.</p>";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtSenha.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Senha' é obrigatório.</p>";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtNome.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Nome' é obrigatório.</p>";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtEndereco.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'endereco' é obrigatório.</p>";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtDescricao.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'descricao' é obrigatório.</p>";
                    return;
                }

                using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand("CALL InserirCliente(@p_nm_email_cliente,@p_nm_cliente,@p_nm_senha,@p_nm_endereco,@p_ds_cliente)", conn);



                    cmd.Parameters.AddWithValue("@p_nm_email_cliente", txtEmail.Text);

                    cmd.Parameters.AddWithValue("@@p_nm_cliente", txtNome.Text);
                    cmd.Parameters.AddWithValue("@p_nm_senha", txtSenha.Text);
                    cmd.Parameters.AddWithValue("@p_nm_endereco", txtEndereco.Text);
                    cmd.Parameters.AddWithValue("@p_ds_cliente", txtDescricao.Text);

                    int resultado = cmd.ExecuteNonQuery();

                    if (resultado > 0)
                    {
                        litMsg.Text = "<p style='color: green;'>Produto adicionado com sucesso!</p>";
                        LimparCampos();
                        Response.Redirect("ListarCliente.aspx", false);
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
            txtEmail.Text = string.Empty;  
            txtNome.Text = string.Empty;
            txtSenha.Text = string.Empty;
            txtEndereco.Text = string.Empty;
            txtDescricao.Text = string.Empty;
           
        }
    }

}