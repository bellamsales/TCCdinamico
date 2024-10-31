using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prjGrowCoiffeur.Logica;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarFuncionario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  
            {
                if (String.IsNullOrEmpty(Request["s"]))
                {
                    Response.Redirect("index.aspx");
                    return;
                }

                string emailAtual = Request["s"];
                txtEmail.Text = emailAtual;  

                try
                {
                    CarregarInformacoesFuncionario(emailAtual);
                }
                catch (Exception ex)
                {
                    litMsg.Text = "<h2 class='erro'>Erro ao carregar as informações do funcionário: " + ex.Message + "</h2>";
                }
            }
        }

        private void CarregarInformacoesFuncionario(string email)
        {
            try
            {
                GiFuncionarios funcionarios = new GiFuncionarios();
                Funcionario funcionario = funcionarios.BuscarDadosFuncionario(email);

                if (funcionario != null)
                {
                    txtNome.Text = funcionario.Nome;
                    txtTelefone.Text = funcionario.Telefone;
                    txtEndereco.Text = funcionario.Endereco;
                    txtCargo.Text = funcionario.Cargo;
                    txtSenha.Text = funcionario.CPF; 

                   
                    txtSenha.ReadOnly = false; 
                    txtSenha.Focus(); 
                    txtSenha.ReadOnly = false; 

                  
                    ClientScript.RegisterStartupScript(this.GetType(), "SelectPassword", "document.getElementById('" + txtSenha.ClientID + "').focus(); document.getElementById('" + txtSenha.ClientID + "').select();", true);
                }
                else
                {
                    throw new Exception("Funcionário não encontrado.");
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao carregar dados do funcionário: " + ex.Message + "</h2>";
                throw;
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

            if (string.IsNullOrWhiteSpace(txtTelefone.Text))
            {
                litMsg.Text = "<p style='color: red;'>O campo 'Endereco' é obrigatório.</p>";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtCargo.Text))
            {
                litMsg.Text = "<p style='color: red;'>O campo 'Endereco' é obrigatório.</p>";
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


        protected void btnexcluir_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            try
            {
                GiFuncionarios giFuncionarios = new GiFuncionarios();

            
                if (giFuncionarios.ExcluirFuncionario(email))
                {
                    litMsg.Text = "<h2 class='sucesso'>Funcionário excluído com sucesso</h2>";
                    Response.Redirect("Funcionario.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<h2 class='erro'>O Funcionário possui agendamentos e foi inativado.</h2>";
                    Response.Redirect("Funcionario.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao excluir o funcionário: " + ex.Message + "</h2>";
            }
        }

    private bool ValidarEmail(string email)
        {
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);
        }

        private bool ValidarTelefone(string telefone)
        {
            
            var numeros = new string(telefone.Where(char.IsDigit).ToArray());
            return numeros.Length == 11; 
        }


        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarCampos())
                    return;

                string emailAtual = Request["s"];
                string novoEmail = txtEmail.Text;

                GiFuncionarios giFuncionarios = new GiFuncionarios();

       
                if (novoEmail != emailAtual && giFuncionarios.EmailExiste(novoEmail))
                {
                    litMsg.Text = "<p style='color: red;'>O email já está em uso. Tente um email diferente.</p>";
                    return;
                }

                Funcionario funcionarioAtual = giFuncionarios.BuscarDadosFuncionario(emailAtual);

               
                Funcionario funcionario = new Funcionario
                {
                    Nome = txtNome.Text,
                    Email = novoEmail,
                    Telefone = LimparTelefone(txtTelefone.Text),
                    Endereco = txtEndereco.Text,
                    Cargo = txtCargo.Text,
                    Senha = string.IsNullOrWhiteSpace(txtSenha.Text) ? funcionarioAtual.Senha : txtSenha.Text.Trim() 
                };

                if (giFuncionarios.EditarFuncionario(emailAtual, novoEmail, funcionario, funcionario.CdFuncionario))
                {
                    litMsg.Text = "<h2 class='sucesso'>Funcionário atualizado com sucesso</h2>";
                    Response.Redirect("Funcionario.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<h2 class='erro'>Erro ao atualizar o funcionário.</h2>";
                }
            }
            catch (Exception ex)
            {
                litMsg.Text = "<h2 class='erro'>Erro ao atualizar o funcionário: " + ex.Message + "</h2>";
            }
        }


            private string LimparTelefone(string telefone)
        {
            return new string(telefone.Where(char.IsDigit).ToArray());
        }

    }
}