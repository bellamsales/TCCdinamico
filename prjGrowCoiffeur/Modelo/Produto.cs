using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

public class Produto
    {
        public int CdProduto { get; set; }
        public string NmProduto { get; set; }
        public string NmMarcaProduto { get; set; }
        public DateTime DtValidadeProduto { get; set; }
        public int QtProdutoEstoque { get; set; }
        public int QtProdutoUtilizado { get; set; }
        public decimal VlProdutoEstoque { get; set; }
        public decimal QtMlProduto { get; set; }
        public decimal QtKgProduto { get; set; }
        public decimal QtLiProduto { get; set; }
        public string NmFornecedorProduto { get; set; }
       public string DsProduto { get; set; }

    public Produto(int cdProduto, string nmProduto, string nmMarcaProduto, DateTime dtValidadeProduto,
                       int qtProdutoEstoque, int qtProdutoUtilizado, decimal vlProdutoEstoque,string dsproduto,
                       decimal qtMlProduto, decimal qtKgProduto, decimal qtLiProduto, string nmFornecedorProduto)
        {
            CdProduto = cdProduto;
            NmProduto = nmProduto;
            NmMarcaProduto = nmMarcaProduto;
            DtValidadeProduto = dtValidadeProduto;
            QtProdutoEstoque = qtProdutoEstoque;
            QtProdutoUtilizado = qtProdutoUtilizado;
            VlProdutoEstoque = vlProdutoEstoque;
            QtMlProduto = qtMlProduto;
            QtKgProduto = qtKgProduto;
            QtLiProduto = qtLiProduto;
            NmFornecedorProduto = nmFornecedorProduto;
            DsProduto=dsproduto;
        }
    public Produto()
    {


    }


    public Produto(int cdProduto, string nmProduto,string dsproduto, int qtProdutoEstoque, decimal vlProdutoEstoque)
    {
        CdProduto = cdProduto;
        NmProduto = nmProduto;
        DsProduto = dsproduto;
        VlProdutoEstoque = vlProdutoEstoque;
        QtProdutoEstoque = qtProdutoEstoque;
    }



}


