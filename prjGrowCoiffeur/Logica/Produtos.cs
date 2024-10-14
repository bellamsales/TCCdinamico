using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


public class Produtos:Banco
{
    public List<Produto> Listar()
    {
        try
        {
            List<Produto> lista = new List<Produto>();

            MySqlDataReader dados = Consultar("ConsultarProdutos", null);
            while (dados.Read())
            {
                Produto clProduto = new Produto(
                    dados.GetInt32(0),
                    dados.GetString(1),
                    dados.GetString(2),
                    dados.GetInt32(3),
                    dados.GetInt32(4));


                lista.Add(clProduto);
            }
            if (dados != null)
            {
                if (!dados.IsClosed)
                {
                    dados.Close();
                }
            }
            Desconectar();

            return lista;
        }
        catch
        {
            throw new Exception("Erro na listagem de produtos");
        }
    }
}
   