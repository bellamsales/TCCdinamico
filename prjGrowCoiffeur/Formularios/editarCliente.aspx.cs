using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Logica;
using prjGrowCoiffeur.Modelo;
using System.Text.RegularExpressions;
using MySqlX.XDevAPI;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request["s"]))
            {
                Response.Redirect("index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string email = Request["s"];
                txtEmail.Text = email;

                try
                {
                    Clientes clientes = new Clientes();

                    Cliente cliente = clientes.BuscarDadosCliente(email);

                    if (cliente != null)
                    {
                        txtNome.Text = cliente.Nome;
                        txtEndereco.Text = cliente.Endereco;
                        txtDescricao.Text = cliente.Descricao;
                        txtSenha.Text = cliente.CPF;
                        txtSenha.ReadOnly = false;


                    }
                    else
                    {
                        throw new Exception("Cliente não encontrado.");
                    }
                }
                catch (Exception ex)
                {
                    litMsg.Text = "<h2 class='erro'>Erro: " + ex.Message + "</h2>";
                }
            }
        }





        protected void btnexcluir_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;

            try
            {
                Clientes clientes = new Clientes();
                bool excluido = clientes.ExcluirCliente(email);

                if (excluido)
                {
                    litMsg.Text = "<h2 class='sucesso'>Cliente excluído com sucesso</h2>";
                    Response.Redirect("ListarClientes.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<h2 class='erro'>O cliente possui agendamentos e foi inativado.</h2>";
                    Response.Redirect("ListarClientes.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao excluir o cliente: " + ex.Message + "</h2>";
            }
        }


        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarCampos())
                    return;

                string emailAtual = Request["s"];
                string novoEmail = txtEmail.Text;

                Clientes clientes = new Clientes();

                if (novoEmail != emailAtual && clientes.EmailExiste(novoEmail))
                {
                    litMsg.Text = "<p style='color: red;'>O email já está em uso. Tente um email diferente.</p>";
                    return;
                }

                Cliente cliente = clientes.BuscarDadosCliente(emailAtual);

                if (cliente != null)
                {
                    
                    string senhaAtualizada = string.IsNullOrWhiteSpace(txtSenha.Text) ? cliente.Senhacliente : txtSenha.Text.Trim();

                    if (clientes.AtualizarCliente(
                        emailAtual,
                        novoEmail,
                        txtNome.Text,
                        senhaAtualizada,
                        txtEndereco.Text,
                        txtDescricao.Text,
                        cliente.CdCliente))
                    {
                        litMsg.Text = "<h2 class='sucesso'>Cliente atualizado com sucesso</h2>";
                        Response.Redirect("ListarClientes.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        litMsg.Text = "<h2 class='erro'>Erro ao atualizar o cliente. Cliente não encontrado ou nenhum dado foi alterado.</h2>";
                    }
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro: " + ex.Message + "</h2>";
            }
        }

        private bool ValidarCampos()
        {
            if (string.IsNullOrWhiteSpace(txtNome.Text))
            {
                litMsg.Text = "<p style='color: red;'>O campo 'Nome' é obrigatório.</p>";
                return false;
            }

            if (!ValidarEmail(txtEmail.Text))
            {
                litMsg.Text = "<p style='color: red;'>O email inserido não é válido. Por favor, insira um email válido.</p>";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtEndereco.Text))
            {
                litMsg.Text = "<p style='color: red;'>O campo 'Endereco' é obrigatório.</p>";
                return false;
            }

            if (!string.IsNullOrWhiteSpace(txtSenha.Text) && txtSenha.Text.Length < 8)
            {
                litMsg.Text = "<p style='color: red;'>A senha deve ter pelo menos 8 caracteres.</p>";
                return false;
            }

        

            return true;
        }

        private bool ValidarEmail(string email)
        {
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);
        }
    }
}