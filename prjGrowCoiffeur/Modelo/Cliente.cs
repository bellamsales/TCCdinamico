using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


    public class Cliente
    {
    public int CdCliente { get; set; }
    public string Email { get; set; }
        public string Nome { get; set; }
       public string Endereco { get; set; }
       public string Descricao { get; set; }
       public string Senhacliente { get; set; }

    public string CPF { get; set; }

    public bool Ativo { get; set; }
    public Cliente() { }

    public Cliente(int cdCliente, string email, string nome, string endereco, string descricao, bool ativo, string cpf)
    {
        CdCliente = cdCliente;
        Email = email;
        Nome = nome;
        Endereco = endereco;
        Descricao = descricao;
        Ativo = ativo;
        CPF = cpf;
    }

   
    public Cliente(int cdCliente, string email, string nome, string senha, string endereco, string descricao, bool ativo, string cpf)
    {
        CdCliente = cdCliente;
        Email = email;
        Nome = nome;
        Senhacliente = senha;
        Endereco = endereco;
        Descricao = descricao;
        Ativo = ativo;
        CPF = cpf;
    }
}

