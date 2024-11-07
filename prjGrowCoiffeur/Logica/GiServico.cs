using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

// Gereciamento Interno

public class GiServico : Banco
{
    public List<Servico> ConsultarServicosPorCategoria(int codigo)
    { 
        List<Servico> servicos = new List<Servico>();
        List<Parametro> parametros = new List<Parametro>();
        Parametro parametro = new Parametro("p_cd_categoria", codigo.ToString());
        parametros.Add(parametro);

        MySqlDataReader dadosBanco = Consultar("ConsultarServicosPorCategoria", parametros);
        if (dadosBanco.HasRows)
        {
            while (dadosBanco.Read())
            {
                Servico servico = new Servico();
                servico.Codigo = int.Parse(dadosBanco["cd_servico"].ToString());
                servico.Nome = dadosBanco["nm_servico"].ToString();
                Categoria categoria = new Categoria();
                categoria.Codigo = int.Parse(dadosBanco["cd_categoria"].ToString());
                servico.Categoria = categoria;
                servicos.Add(servico);
            }
        }
        if (!dadosBanco.IsClosed)
            dadosBanco.Close();
        Desconectar();
        return servicos;
    }

    public bool AgendarServico(string cliente, int servico, TimeSpan hora, DateTime data, string funcionario)
    {
        List<Parametro> parametros = new List<Parametro>
        {
            new Parametro("pCliente", cliente),
            new Parametro("pServico", servico.ToString()),
            new Parametro("pHora", hora.ToString()),
            new Parametro("pData", data.ToString("yyyy-MM-dd")), 
            new Parametro("pFuncionario", funcionario)
        };

        try
        {
            Conectar();
            Executar("AgendarServico", parametros);
            Desconectar();
            return true;
        }
        catch (Exception)
        {
            return false;
        }

    }
    public void AdicionarServico(int codigo, string nome, double valor, string tempo)
    {
        List<Parametro> parametros = new List<Parametro>();
        parametros.Add(new Parametro("pCodigo", codigo));
        parametros.Add(new Parametro("pNome", nome));
        parametros.Add(new Parametro("pValor", valor));
        parametros.Add(new Parametro("pTempoServico", tempo));
        Conectar();
        Executar("ADICIONARSERVICO", parametros);
    }

    public int BuscarCodigo()
    {
        MySqlDataReader dados = null;
        int codigo = 0;

        try
        {
            dados = Consultar("ADICIONARCODIGO", null);

            if (dados.Read())
            {
                codigo = dados.GetInt16(0);
            }
        }

        catch
        {
            throw new Exception("Erro ao Buscar Código.");
        }

        finally
        {
            Desconectar();
        }

        return codigo;
    }

    public List<Servico> ListarServicoCabelo() 
    {
        try
        {
            Conectar();
            MySqlDataReader dados = Consultar("ListarServicosCabelo", null);

            List<Servico> servicos = new List<Servico>();

            while (dados.Read())
            {
                Servico servico = new Servico();

                servico.Codigo = dados.GetInt32(0);
                servico.Nome = dados.GetString(1);
                servico.Descrição = dados.GetString(2);
                servico.ValorMonetario = dados.GetDouble(3);
                servico.TempoEstimado = dados.GetTimeSpan(4);

                Categoria categoria = new Categoria();
                categoria.Codigo = dados.GetInt32(5);
                categoria.Nome = dados.GetString(6);

                servico.Categoria = categoria;

                servicos.Add(servico);
            }

            return servicos;
        }
        catch
        {
            throw new Exception("Não foi possível listar os tipos de serviço de cabelo");
        }
        finally
        {
            Desconectar();
        }
    }

    public List<Servico> ListarServicoUnha()
    {
        try
        {
            Conectar();
            MySqlDataReader dados = Consultar("ListarServicoUnha", null);

            List<Servico> servicos = new List<Servico>();

            while (dados.Read())
            {
                Servico servico = new Servico();

                servico.Codigo = dados.GetInt32(0);
                servico.Nome = dados.GetString(1);
                servico.Descrição = dados.GetString(2);
                servico.ValorMonetario = dados.GetDouble(3);
                servico.TempoEstimado = dados.GetTimeSpan(4);

                Categoria categoria = new Categoria();
                categoria.Codigo = dados.GetInt32(5);
                categoria.Nome = dados.GetString(6);

                servico.Categoria = categoria;

                servicos.Add(servico);
            }

            return servicos;
        }
        catch
        {
            throw new Exception("Não foi possível listar os tipos de serviço de unha");
        }
        finally
        {
            Desconectar();
        }
    }

    public Servico BuscarDados(int codigo)
    {
        try
        {
            Conectar();

            List<Parametro> p = new List<Parametro>();
            p.Add(new Parametro("pcodigo", codigo));

            MySqlDataReader dados = Consultar("BuscarDadosServico", p);

            Servico servico = new Servico();

            if (dados.Read())
            {
                servico.Codigo = dados.GetInt32(0);
                servico.Nome = dados.GetString(1);
                servico.Descrição = dados.GetString(2);
                servico.ValorMonetario = dados.GetDouble(3);
                servico.TempoEstimado = dados.GetTimeSpan(4);
                
                Categoria categoria = new Categoria();
                categoria.Codigo = dados.GetInt32(5);
                categoria.Nome = dados.GetString(6);

                servico.Categoria = categoria;
            }

            return servico;
        }
        catch (Exception erro)
        {
            throw new Exception(erro.Message);
        }
        finally
        {
            Desconectar();
        }
    }

    public void ExcluirServico(int codigo)
    {
        try
        {
            Conectar();

            List<Parametro> p = new List<Parametro>();
            p.Add(new Parametro("pcodigo", codigo));

            Executar("ExcluirServico", p);
        }
        catch
        {
            throw new Exception("Não foi possível excluir o serviço");
        }
        finally
        {
            Desconectar();
        }
    }

    public void AtualziarDadosServico(int codigo, string nome, string descricao, double valor, string tempo)
    {
        try
        {
            Conectar();

            List<Parametro> p = new List<Parametro>();
            p.Add(new Parametro("pcodigo", codigo));
            p.Add(new Parametro("pnome", nome));
            p.Add(new Parametro("pdescricao", descricao));
            p.Add(new Parametro("pvalor", valor));
            p.Add(new Parametro("ptempo", tempo));

            Executar("AtualizarDadosServico", p);
        }
        catch
        {
            throw new Exception("Não foi possível atualziar os dados");
        }
        finally
        {
            Desconectar();
        }
    }
}