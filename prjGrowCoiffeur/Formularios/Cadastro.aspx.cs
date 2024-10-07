using Mysqlx;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TCC_GLOW_COIFFEUR
{
    public partial class Cadastro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btn_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtemail.Text))
                {
                    litmensage.Text = "A caixa email não pode ser vazia";
                    return; 
                }

                if (string.IsNullOrWhiteSpace(Txtnome.Text))
                {
                    litmensage.Text = "A caixa do nome não pode ser vazia";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtsenha.Text))
                {
                    litmensage.Text = "A caixa da senha não pode ser vazia";
                    return;
                }

                Usuario usuario = new Usuario();
                string email = txtemail.Text.Trim();
                string nome = Txtnome.Text.Trim();
                string senha = txtsenha.Text.Trim();

                if (!usuario.Verificarlogin(email))
                {
                    usuario.Cadatrarcli(nome, email, senha);
                    litmensage.Text = "Usuário cadastrado com sucesso";
                }
                else
                {
                    litmensage.Text = "Email já cadastrado, redirecionando para login...";
                    Response.Redirect("login.aspx");
                }
            }
            catch (Exception ex)
            {
                litmensage.Text = "Ocorreu um erro: " + ex.Message;
            }
        }
    }
}