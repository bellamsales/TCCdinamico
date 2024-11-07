using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class EditarServico : System.Web.UI.Page
    {
        int codigo = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["c"] != null)
            {
                if (!String.IsNullOrEmpty(Request["c"]))
                {
                    codigo = int.Parse(Request["c"]);
                }
            }
            else
            {
                Response.Redirect("Servico.aspx");
                return;
            }

            if (!IsPostBack)
            {
                GiServico Giservico = new GiServico();
                Servico servico = Giservico.BuscarDados(codigo);

                if (servico != null)
                {
                    txtCodigo.Text = servico.Codigo.ToString();
                    txtNome.Text = servico.Nome;
                    txtPreco.Text = servico.ValorMonetario.ToString();
                    txtTempo.Text = servico.TempoEstimado.ToString();
                    txtDescricao.Text = servico.Descrição.ToString();
                }
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            GiServico giServico = new GiServico();

            string nome = txtNome.Text;
            string descricao = txtDescricao.Text;
            double valor = double.Parse(txtPreco.Text);
            string tempo = txtTempo.Text;
          

            giServico.AtualziarDadosServico(codigo, nome, descricao, valor, tempo);

            Response.Redirect("Servico.aspx");
            return;
        }
    }
}