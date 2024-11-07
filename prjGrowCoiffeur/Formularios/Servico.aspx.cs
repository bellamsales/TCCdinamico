using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjGrowCoiffeur.Formularios
{
    public partial class PagServico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GiServico giServico = new GiServico();
            List<Servico>  servicos = giServico.ListarServicoCabelo();

            foreach (Servico servico in servicos)
            {
                litServicosCabelo.Text += $@"<li>
                                                <a href=ExcluirServico.aspx?c={servico.Codigo}><i class='bi bi-trash'></i></a>
                                                <span>{servico.Nome}</span>
                                                <a href=EditarServico.aspx?c={servico.Codigo}><i class='bi bi-pencil-square'></i></a>
                                            </li>";
            }

            servicos = giServico.ListarServicoUnha();

            foreach (Servico servico in servicos)
            {
                litServicosUnha.Text += $@"<li>
                                            <span>{servico.Nome}</span>
                                            <a href=ExcluirServico.aspx?c={servico.Codigo}><i class='bi bi-trash'></i></a>
                                            <a href=EditarServico.aspx?c={servico.Codigo}><i class='bi bi-pencil'></i></a>
                                          </li>";
            }

        }
    }
}