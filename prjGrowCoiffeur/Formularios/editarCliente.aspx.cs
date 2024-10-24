using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (String.IsNullOrEmpty(Request["s"]))
            {
                Response.Redirect("index.aspx");
                return;
            }
            string email = Request["s"];
            txtEmail.Text = email;
            if (!IsPostBack)
            {
                try
                {   Clientes clientes = new Clientes();
                    Produtos produtos = new Produtos();
                    Cliente cliente = clientes.BuscarDadosCliente( email);

                    if (cliente != null)
                    {
                        txtEmail.Text = email;
                        txtNome.Text = cliente.Nome;
                        txtEndereco.Text = cliente.Endereco;
                        txtDescricao.Text = cliente.Descricao;
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
            string email = txtEmail.Text;
            string connectionString = "SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                  
                    string deleteAgendamentosQuery = "DELETE FROM agendamento WHERE nm_email_cliente = @p_nm_email_cliente";
                    using (MySqlCommand cmdDeleteAgendamentos = new MySqlCommand(deleteAgendamentosQuery, conn))
                    {
                        cmdDeleteAgendamentos.Parameters.AddWithValue("@p_nm_email_cliente", email);
                        cmdDeleteAgendamentos.ExecuteNonQuery();
                    }

                   
                    string query = "CALL excluirCliente(@p_nm_email_cliente)";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@p_nm_email_cliente", email);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            litMsg.Text = "<h2 class='sucesso'>Produto excluído com sucesso</h2>";
                            Response.Redirect("ListarClientes.aspx", false); 
                            Context.ApplicationInstance.CompleteRequest(); 
                        }
                        else
                        {
                            litMsg.Text = "<h2 class='erro'>Erro ao excluir o produto. Produto não encontrado.</h2>";
                        }
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
            string email = txtEmail.Text;
            string connectionString = "SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
               
                string query = "CALL AtualizarCliente( @p_nm_email_cliente,@p_nm_cliente,@p_nm_endereco,@p_ds_cliente)";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@p_nm_email_cliente", txtEmail.Text);
                cmd.Parameters.AddWithValue("@p_nm_cliente", txtNome.Text);
                cmd.Parameters.AddWithValue("@p_nm_endereco", txtEndereco.Text);
                cmd.Parameters.AddWithValue("@p_ds_cliente", txtDescricao.Text);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        litMsg.Text = "<h2 class='sucesso'>Produto atualizado com sucesso</h2>";
                        Response.Redirect("ListarClientes.aspx", false);
                        Context.ApplicationInstance.CompleteRequest(); 
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
    
