using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


public class Produtos: Banco
{
    public List<clsProduto> Listar()
    {
        try
        {
            List<clsProduto> lista = new List<clsProduto>();

            MySqlDataReader dados = Consultar("ConsultarProdutos", null);
            while (dados.Read())
            {
                clsProduto clProduto = new clsProduto(
                    dados.GetInt32(0),
                    dados.GetString(1),
                    dados.GetString(2),
                    dados.GetDateTime(3),
                    dados.GetInt32(4),
                    dados.GetInt32(5),
                    dados.GetDecimal(6),
                    dados.GetString(7)

                ) ;


                lista.Add(clProduto);
            }

            if (dados != null && !dados.IsClosed)
            {
                dados.Close();
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
