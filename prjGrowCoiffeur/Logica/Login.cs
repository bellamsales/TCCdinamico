using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Logica
{
    public class Login : Banco
    {
        public bool LoginCliente(string email, string senha)
        {
            bool mensagemRetorno = false;
            List<Parametro> parametros = new List<Parametro>();


            parametros.Add(new Parametro("p_email_cliente", email));
            parametros.Add(new Parametro("p_senha_cliente", senha));


            MySqlDataReader dadosBanco = Consultar("LoginCliente", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    mensagemRetorno = (bool)dadosBanco["mensagem"];
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();

            return mensagemRetorno;
        }

        public bool LoginFuncionario(string email, string senha)
        {
            bool mensagemRetorno = false;
            List<Parametro> parametros = new List<Parametro>();

            parametros.Add(new Parametro("p_email_funcionario", email));
            parametros.Add(new Parametro("p_senha_funcionario", senha));

            MySqlDataReader dadosBanco = Consultar("LoginFuncionario", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    mensagemRetorno = (bool)dadosBanco["mensagem"];
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();

            return mensagemRetorno;
        }

        public bool LoginGerente(string email, string senha)
        {
            bool mensagemRetorno = false;
            List<Parametro> parametros = new List<Parametro>();

            parametros.Add(new Parametro("p_email_gerente", email));
            parametros.Add(new Parametro("p_senha_gerente", senha));

            MySqlDataReader dadosBanco = Consultar("LoginGerente", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    mensagemRetorno = (bool)dadosBanco["mensagem"];
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();

            return mensagemRetorno;
        }
    }
}