using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

public partial class clsProduto
{
    public int CdProduto { get; set; }
    public string NmProduto { get; set; }
    public string NmMarcaProduto { get; set; }
    public DateTime DtValidadeProduto { get; set; }
    public int QtProdutoEstoque { get; set; }
    public int QtProdutoUtilizado { get; set; }
    public decimal VlProdutoEstoque { get; set; }
    public string NmFornecedorProduto { get; set; }
    public string DsProduto { get; set; }

    public clsProduto(int cdProduto, string nmProduto, string nmMarcaProduto, DateTime dtValidadeProduto,
                      int qtProdutoEstoque, int qtProdutoUtilizado, decimal vlProdutoEstoque, string nmFornecedorProduto)
    {
        CdProduto = cdProduto;
        NmProduto = nmProduto;
        NmMarcaProduto = nmMarcaProduto;
        DtValidadeProduto = dtValidadeProduto;
        QtProdutoEstoque = qtProdutoEstoque;
        QtProdutoUtilizado = qtProdutoUtilizado;
        VlProdutoEstoque = vlProdutoEstoque;
        NmFornecedorProduto = nmFornecedorProduto;
        
    }

public clsProduto()
    {


    }


    public clsProduto(int cdProduto, string nmProduto, string nmMarcaProduto)
    {
        CdProduto = cdProduto;
        NmProduto = nmProduto;
        NmMarcaProduto = nmMarcaProduto;
       

    }
    public clsProduto(int cdProduto, string nmProduto, string nmMarcaProduto,
    DateTime dtValidadeProduto,int qtProdutoEstoque,decimal vlProdutoEstoque)
    {
        CdProduto = cdProduto;
        NmProduto = nmProduto;
        NmMarcaProduto = nmMarcaProduto;
        DtValidadeProduto = dtValidadeProduto;
        QtProdutoEstoque = qtProdutoEstoque;
        VlProdutoEstoque = vlProdutoEstoque;
    }
}





