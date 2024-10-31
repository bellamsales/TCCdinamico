using MySql.Data.MySqlClient;
using prjGrowCoiffeur;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

public class Clientes : Banco
{
    public List<Cliente> Listar()
    {
        try
        {
            List<Cliente> lista = new List<Cliente>();
            MySqlDataReader dados = Consultar("ConsultarClientes", null);

            while (dados.Read())
            {
                Cliente cliente = new Cliente(
                    dados.GetInt32(0),
                    dados.GetString(1),
                    dados.GetString(2),
                    dados.GetString(3),
                    dados.GetString(4),
                    dados.GetBoolean(5),
                     dados.GetString(6)
                );

                lista.Add(cliente);
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
            throw new Exception("Erro na listagem de clientes: " + ex.Message);
        }
    }
    public Cliente BuscarDadosCliente(string email)
    {
        Cliente cliente = null;
        try
        {
            List<Parametro> parametros = new List<Parametro>
        {
            new Parametro("p_nm_email_cliente", email)
        };

            MySqlDataReader dados = Consultar("ConsultarClientesporemail", parametros);

            if (dados.Read())
            {
                cliente = new Cliente(
                    dados.GetInt32(0),
                    dados.GetString(1),
                    dados.GetString(2),
                    dados.GetString(3),
                    dados.GetString(4),
                    dados.GetBoolean(5),
                     dados.GetString(6)
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
            throw new Exception("Erro ao buscar dados do Cliente: " + ex.Message);
        }
        return cliente;
    }
    public bool AdicionarCliente(string email, string nome, string senha, string endereco, string descricao, string cpf)
    {
        List<Parametro> parametros = new List<Parametro>
    {
        new Parametro("p_nm_email_cliente", email),
        new Parametro("p_nm_cliente", nome),
        new Parametro("p_nm_senha", senha),
        new Parametro("p_nm_endereco", endereco),
        new Parametro("p_ds_cliente", descricao),
        new Parametro("p_nm_cpf", cpf)
    };

        try
        {
            Conectar();
            Executar("InserirCliente", parametros);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao adicionar cliente: " + ex.Message);
        }
    }

    public bool EmailExiste(string email)
    {
        using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Cliente WHERE nm_email_cliente = @p_email", conn);
            cmd.Parameters.AddWithValue("@p_email", email);

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            return count > 0;
        }
    }

    public bool ClienteTemAgendamentos(string email)
    {
        using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Agendamento WHERE nm_email_cliente = @p_email", conn);
            cmd.Parameters.AddWithValue("@p_email", email);

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            return count > 0;
        }
    }

    public bool ClienteInativo(string email)
    {
        List<Parametro> parametros = new List<Parametro>
    {
        new Parametro("p_nm_email_cliente", email)
    };

        try
        {
            Conectar();
            Executar("ClienteInativo", parametros);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao inativar o cliente: " + ex.Message);
        }
    }


    public bool ExcluirCliente(string email)
    {

        if (!EmailExiste(email))
        {
            throw new Exception("Cliente não encontrado.");
        }

        if (ClienteTemAgendamentos(email))
        {

            try
            {
                List<Parametro> parametros = new List<Parametro>
            {
                new Parametro("p_nm_email_cliente", email)
            };
                Conectar();
                Executar("ClienteInativo", parametros);
                Desconectar();
                return false;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao inativar cliente: " + ex.Message);
            }
        }


        List<Parametro> parametrosDelete = new List<Parametro>
    {
        new Parametro("p_nm_email_cliente", email)
    };

        try
        {
            Conectar();
            Executar("ExcluirCliente", parametrosDelete);
            Desconectar();
            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao excluir cliente: " + ex.Message);
        }
    }


    public bool AtualizarCliente(string emailAtual, string novoEmail, string nome, string senha, string endereco, string descricao, int CdCliente)
    {
        try
        {
            
          
           
            Conectar();

      
            if (!EmailExiste(emailAtual))
            {
                throw new Exception("O cliente não existe.");
            }

           
            List<Parametro> parametros = new List<Parametro>
        {
            new Parametro("p_nm_email_cliente", emailAtual),
            new Parametro("p_nm_novo_email", novoEmail),
            new Parametro("p_nm_cliente", nome),
            new Parametro("p_nm_senha", senha),
            new Parametro("p_nm_endereco", endereco),
            new Parametro("p_ds_cliente", descricao),
             new Parametro("p_cd_cliente", CdCliente)
        };

            
            Executar("AtualizarCliente", parametros);

            List<Parametro> emailParams = new List<Parametro>
        {
            new Parametro("p_email_atual", emailAtual),
            new Parametro("p_email_novo", novoEmail)
        };

            Executar("AtualizarEmailAgendamentos", emailParams);
            Executar("AtualizarEmailFeedbacks", emailParams);

            return true;
        }
        catch (Exception ex)
        {
            throw new Exception("Erro ao atualizar cliente: " + ex.Message);
        }
        finally
        {
            Desconectar(); 
        }
    }
}