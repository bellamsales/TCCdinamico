using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;


    public class Funcionario
    {
        public int CdFuncionario { get; set; }
        public string Email { get; set; }
        public string Nome { get; set; }
        public string Telefone { get; set; }
        public string Endereco { get; set; }
        public string Cargo { get; set; }
        public string CPF { get; set; }
        public Servico Especialidade { get; set; }

        public string Senha { get; set; }

        public bool Ativo { get; set; }



        public Funcionario()
        {
        }

        
        public Funcionario(int cdFuncionario, string email, string nome, string telefone, string endereco, string cargo, string cpf, Servico especialidade, string senha, bool ativo)
        {
            Email = email;
            Nome = nome;
            Telefone = telefone;
            Endereco = endereco;
            Cargo = cargo;
            CPF = cpf;
            Especialidade = especialidade;
            Senha = senha;
            CdFuncionario = cdFuncionario;
            Ativo = ativo;
        }


    }