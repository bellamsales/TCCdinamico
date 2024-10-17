using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;


public partial class Produto : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CarregarProdutos();
        }
    }



    private void CarregarProdutos()
    {

        try
        {
            Produtos produtos = new Produtos();
            List<Produto> lista_produtos = produtos.Listar();

            if (lista_produtos.Count > 0)
            {

                for (int i = 0; i < lista_produtos.Count; i++)
                {
                    
                    //lit
                    
                    //litnomeproduto.text. = lista_produtos[i].CdProduto;
                    //litprecoproduto.Text = lista_produtos[i].NmProduto;
                    //litmarcaproduto.Text = lista_produtos[i].NmMarcaProduto;


                }
            }
        }
        catch (Exception)
        {
            Response.Redirect("erro.html");
        }
    }
}
    
//exemplo
// //LitProdutos.Text += $@"<tr>
//                    //                                    <td>{lista_produtos[i].CdProduto}</td>
//                    //                                    <td>{lista_produtos[i].NmProduto}</td>
//                    //                                    <td>{lista_produtos[i].VlProdutoEstoque.ToString("C")}</td>
//                    //                                </tr>";

//                    //está falando que nâo existe litProdutos no contexto atual 