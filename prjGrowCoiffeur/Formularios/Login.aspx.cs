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

            // Primeiro, tente fazer login como gerente
            bool gerenteLogado = login.LoginGerente(email, senha);
            if (gerenteLogado)
            {
                Session["TipoUsuario"] = "gerente";
                Session["EmailUsuario"] = email;
                Response.Redirect("Agendamentos.aspx");
                return;
            }

            // Agora tente fazer login como funcionário
            bool funcionarioLogado = login.LoginFuncionario(email, senha);
            if (funcionarioLogado)
            {
                Session["TipoUsuario"] = "funcionario";
                Session["EmailUsuario"] = email;
                Response.Redirect("Agendar.aspx");
                return;
            }

            // Se nenhuma das opções acima funcionar, busque os dados do cliente
            Clientes clientes = new Clientes();
            Cliente cliente = clientes.BuscarDadosCliente(email);

            // Verifique se o cliente foi encontrado
            if (cliente == null)
            {
                lblMensagem.Text = "Cliente não encontrado!";
                return;
            }

            // Verifique se o cliente está ativo
            if (!cliente.Ativo)
            {
                lblMensagem.Text = "Cliente inativo!";
                return;
            }

            // Verifique se o cliente pode se logar
            bool clienteLogado = login.LoginCliente(email, senha);
            if (clienteLogado)
            {
                Session["TipoUsuario"] = "cliente";
                Session["EmailUsuario"] = email;
                Response.Redirect("Agendar.aspx");
                return;
            }

            // Mensagem de erro se nenhum login for bem-sucedido
            lblMensagem.Text = "Email ou senha incorretos!";
        }
    }
}