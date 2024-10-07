using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            var login = new Logica.Login();
            string email = txtEmail.Text.Trim().ToLower();
            string senha = txtSenha.Text.Trim();


            bool clienteLogado = login.LoginCliente(email, senha);

            if (clienteLogado)
            {

                Session["TipoUsuario"] = "cliente";
                Session["EmailUsuario"] = email;

                Response.Redirect("Agendar.aspx");
            }
            else
            {

                bool funcionarioLogado = login.LoginFuncionario(email, senha);

                if (funcionarioLogado)
                {

                    Session["TipoUsuario"] = "funcionario";
                    Session["EmailUsuario"] = email;

                    Response.Redirect("Agendar.aspx");
                }
                else
                {

                    lblMensagem.Text = "Email ou senha incorretos!";
                }
            }
        }
    }
}