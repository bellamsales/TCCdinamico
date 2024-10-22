using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class editarCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (String.IsNullOrEmpty(Request["c"]))
            {
                Response.Redirect("index.aspx");
                return;
            }
            string email = Request["c"].ToString();
            txtEmail.Text = email.ToString();
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
    }
}