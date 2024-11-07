using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class servico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GiServico servico = new GiServico();
                txtCodigo.Text = servico.BuscarCodigo().ToString();
            }
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            try
            {
                GiServico servico = new GiServico();
                servico.AdicionarServico(int.Parse(txtCodigo.Text), txtNome.Text, double.Parse(txtPreco.Text), txtTempo.Text);

                txtCodigo.Text = "";
                txtNome.Text = "";
                txtPreco.Text = "";
                txtTempo.Text = "";
                litMsg.Text = "deu certo";
                txtCodigo.Text = servico.BuscarCodigo().ToString();
            }
            catch (Exception ex)
            {
                litMsg.Text = ex.Message;
            }
        }
    }
}