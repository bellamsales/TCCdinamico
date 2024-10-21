using MySql.Data.MySqlClient;
using prjGrowCoiffeur;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


public class Produtos : Banco
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

                );


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
    //public Produto BuscarDadosProduto(int codigoProduto)
    //{
    //    clsProduto produto = null;
    //    try
    //    {
    //        List<MySqlParameter> parametros = new List<MySqlParameter>();
    //        parametros.Add(new MySqlParameter("pCodigo", codigoProduto.ToString()));
    //        MySqlDataReader dados = Consultar("buscarDadosProdutoPorCodigo", parametros);

    //        if (dados.Read())
    //        {

    //            produto = new clsProduto(
    //            codigoProduto,
    //            dados.GetString(0),
    //            dados.GetString(1),
    //            dados.GetDateTime(2),
    //            dados.GetInt32(3),
    //            dados.GetDecimal(4)
    //            );
    //        }
    //        if (dados != null)
    //        {
    //            if (!dados.IsClosed)
    //            {
    //                dados.Close();
    //            }
    //        }
    //        Desconectar();
    //    }
    //    catch
    //    {
    //        throw new Exception("Erro ao buscar dados do Produto");
    //    }
    //    return produto;
    //}
    public clsProduto BuscarDadosProduto(int codigoProduto)
    {
        clsProduto produto = null;
        try
        {
            List<Parametro> parametros = new List<Parametro>
        {
            new Parametro("pCodigo", codigoProduto)
        };

            MySqlDataReader dados = Consultar("buscarDadosProdutoPorCodigo", parametros);

            if (dados.Read())
            {
                produto = new clsProduto(
                    dados.GetInt32(0), // cd_produto
                    dados.GetString(1), // nm_produto
                    dados.GetString(2), // nm_marca_produto
                    dados.GetDateTime(3), // dt_validade_produto
                    dados.GetInt32(4), // qt_produto_estoque
                    dados.GetDecimal(5) // vl_produto_estoque
                );
            }

            if (dados != null && !dados.IsClosed)
            {
                dados.Close();
            }
            Desconectar();
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao buscar dados do Produto: " + ex.Message);
        }
        return produto;
    }
}