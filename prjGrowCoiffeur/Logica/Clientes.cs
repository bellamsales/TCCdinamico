using MySql.Data.MySqlClient;
using prjGrowCoiffeur;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

    public class Clientes:Banco
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
                    dados.GetString(0),
                    dados.GetString(1),
                    dados.GetString(2),
                    dados.GetString(3)

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
        catch
        {
            throw new Exception("Erro na listagem de produtos");
        }
    }
    public Cliente BuscarDadosCliente(string email)
    {
        Cliente cliente= null;
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
                    dados.GetString(0), 
                    dados.GetString(1), 
                    dados.GetString(2),
                    dados.GetString(3)
                   
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
        return cliente;
    }



  
}