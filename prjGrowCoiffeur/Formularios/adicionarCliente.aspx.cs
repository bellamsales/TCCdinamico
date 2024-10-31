using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
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
                if (string.IsNullOrWhiteSpace(txtCPF.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'CPF' é obrigatório.</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtNome.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Nome' é obrigatório.</p>";
                    return;
                }
                if (!ValidarEmail(txtEmail.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O email inserido não é válido. Por favor, insira um email válido.</p>";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtSenha.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Senha' é obrigatório.</p>";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtEndereco.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O campo 'Endereco' é obrigatório.</p>";
                    return;
                }

                string cpfLimpo = LimparCPF(txtCPF.Text);
                if (!ValidarCPF(cpfLimpo))
                {
                    litMsg.Text = "<p style='color: red;'>O CPF inserido não é válido.</p>";
                    return;
                }

                if (!string.IsNullOrWhiteSpace(txtSenha.Text) && txtSenha.Text.Length < 8)
                {
                    litMsg.Text = "<p style='color: red;'>A senha deve ter pelo menos 8 caracteres.</p>";
                    return;
                }



                Clientes clientesLogica = new Clientes();
                if (clientesLogica.EmailExiste(txtEmail.Text))
                {
                    litMsg.Text = "<p style='color: red;'>O email já está em uso. Tente um email diferente.</p>";
                    return;
                }

              
                bool clienteAdicionado = clientesLogica.AdicionarCliente(
                    txtEmail.Text,
                    txtNome.Text,
                    txtSenha.Text,
                    txtEndereco.Text,
                    txtDescricao.Text,
                    cpfLimpo
                );

                if (clienteAdicionado)
                {
                    litMsg.Text = "<p style='color: green;'>Cliente adicionado com sucesso!</p>";
                    LimparCampos();
                    Response.Redirect("ListarClientes.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    litMsg.Text = "<p style='color: red;'>Erro ao adicionar o Cliente.</p>";
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

      

        private bool ValidarEmail(string email)
        {
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);
        }

        private void LimparCampos()
        {
            txtEmail.Text = string.Empty;
            txtNome.Text = string.Empty;
            txtSenha.Text = string.Empty;
            txtEndereco.Text = string.Empty;
            txtDescricao.Text = string.Empty;
            txtCPF.Text = string.Empty;

        }

        private string LimparCPF(string cpf)
        {

            return new string(cpf.Where(char.IsDigit).ToArray());
        }

        private bool ValidarCPF(string cpf)
        {

            if (cpf.Length != 11)
                return false;


            int[] cpfDigits = cpf.Select(c => int.Parse(c.ToString())).ToArray();
            int firstDigit = 0;
            int secondDigit = 0;


            for (int i = 0; i < 9; i++)
                firstDigit += cpfDigits[i] * (10 - i);
            firstDigit = (firstDigit * 10) % 11;
            if (firstDigit == 10) firstDigit = 0;


            for (int i = 0; i < 10; i++)
                secondDigit += cpfDigits[i] * (11 - i);
            secondDigit = (secondDigit * 10) % 11;
            if (secondDigit == 10) secondDigit = 0;


            return (firstDigit == cpfDigits[9]) && (secondDigit == cpfDigits[10]);
        }
    }
}