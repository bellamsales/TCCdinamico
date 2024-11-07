using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class ExcluirServico : System.Web.UI.Page
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
                Response.Redirect("PagServico.aspx");
                return;
            }

            GiServico Giservico = new GiServico();
            Servico servico =  Giservico.BuscarDados(codigo);

            if (servico != null)
            {
                txtCodigo.Text = servico.Codigo.ToString();
                txtNome.Text = servico.Nome;
                txtPreco.Text = servico.ValorMonetario.ToString("C");
                txtTempo.Text = servico.TempoEstimado.ToString();
                txtDescricao.Text = servico.Descrição;
            }
        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            GiServico giServico = new GiServico();
            giServico.ExcluirServico(codigo);

            Response.Redirect("Servico.aspx");
            return;
        }
    }
}