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

            
            if (dados != null && dados.HasRows)
            {
                while (dados.Read())
                {
                   
                    clsProduto clProduto = new clsProduto(
                        dados.IsDBNull(0) ? 0 : dados.GetInt32(0),
                        dados.IsDBNull(1) ? "N/A" : dados.GetString(1),
                        dados.IsDBNull(2) ? "N/A" : dados.GetString(2),
                        dados.IsDBNull(3) ? DateTime.MinValue : dados.GetDateTime(3),
                        dados.IsDBNull(4) ? 0 : dados.GetInt32(4),
                        dados.IsDBNull(5) ? 0 : dados.GetInt32(5),
                        dados.IsDBNull(6) ? 0 : dados.GetDecimal(6),
                        dados.IsDBNull(7) ? "N/A" : dados.GetString(7)
                    );

                    lista.Add(clProduto);
                }
            }

            if (dados != null && !dados.IsClosed)
            {
                dados.Close();
            }

            Desconectar();

            return lista;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro na listagem de produtos: " + ex.Message);
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
                    dados.GetInt32(0), 
                    dados.GetString(1), 
                    dados.GetString(2), 
                    dados.GetDateTime(3),
                    dados.GetInt32(4),
                    dados.GetDecimal(5) 
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

    public bool AdicionarProduto(clsProduto produto)
    {
        List<Parametro> parametros = new List<Parametro>
    {
         new Parametro("p_cd_produto", produto.CdProduto),
        new Parametro("p_nm_produto", produto.NmProduto),
        new Parametro("p_nm_marca_produto", produto.NmMarcaProduto),
        new Parametro("p_vl_produto_estoque", produto.VlProdutoEstoque),
        new Parametro("p_dt_validade_produto", produto.DtValidadeProduto),
        new Parametro("p_qt_produto_estoque", produto.QtProdutoEstoque)
    };

        try
        {
            Conectar();
            Executar("InserirProduto", parametros);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao adicionar produto: " + ex.Message);
        }
    }

    public bool ExcluirProduto(int codigoProduto)
    {
        List<Parametro> parametros = new List<Parametro>
    {
        new Parametro("p_cd_produto", codigoProduto)
    };

        try
        {
            Conectar();
            Executar("ExcluirProduto", parametros);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao excluir produto: " + ex.Message);
        }
    }

    public bool EditarProduto(clsProduto produto)
    {
        List<Parametro> parametros = new List<Parametro>
    {
        new Parametro("p_cd_produto", produto.CdProduto),
        new Parametro("p_nm_produto", produto.NmProduto),
        new Parametro("p_nm_marca_produto", produto.NmMarcaProduto),
        new Parametro("p_vl_produto_estoque", produto.VlProdutoEstoque),
        new Parametro("p_dt_validade_produto", produto.DtValidadeProduto),
        new Parametro("p_qt_produto_estoque", produto.QtProdutoEstoque)
    };

        try
        {
            Conectar();
            Executar("AtualizarProduto", parametros);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao editar produto: " + ex.Message);
        }
    }
}
