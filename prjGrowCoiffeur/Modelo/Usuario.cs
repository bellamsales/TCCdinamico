using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Usuario : Banco
    {
        private string _nome;
        private string _email;
        private string _senha;
        private string _dscliente;
        private string _endereco;

        public string Nome
        {
            get { return _nome; }
            set { _nome = value; }
        }


        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }


        public string Senha
        {
            get { return _senha; }
            set { _senha = value; }
        }



        public string Endereco
        {
            get { return _endereco; }
            set { _endereco = value; }
        }




        public string Dscliente
        {
            get { return _dscliente; }
            set { _dscliente = value; }
        }



        public void Cadatrarcli(string nome, string email, string senha)
        {
            List<Parametro> parameters = new List<Parametro>();

            parameters.Add(new Parametro("p_nm_cliente", nome));
            parameters.Add(new Parametro("p_nm_email_cliente", email));
            parameters.Add(new Parametro("p_nm_senha", senha));

            string comando = "CadastrarCliente";
            Executar(comando, parameters);

        }

        public bool Verificarlogin(string email)
        {

            List<Parametro> parameters = new List<Parametro>
    {
        new Parametro("p_nm_email_cliente", email)
    };

            string comando = "VerificarCliente";

            using (MySqlDataReader dados = Consultar(comando, parameters))
            {
                return dados.Read();
            }
        }
    }
}
