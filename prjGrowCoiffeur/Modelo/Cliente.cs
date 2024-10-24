using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Cliente
{
    public string Email { get; set; }
    public string Nome { get; set; }
    public string Endereco { get; set; }
    public string Descricao { get; set; }
    public string Senhacliente { get; set; }
    public Cliente()
    {

    }
    public Cliente(string nomeemail, string nomecliente, string endereco, string descricao)
    {
        Email = nomeemail;
        Nome = nomecliente;
        Endereco = endereco;
        Descricao = descricao;
    }
    public Cliente(string nomeemail, string nomecliente, string senha, string endereco, string descricao)
    {
        Email = nomeemail;
        Nome = nomecliente;
        Senhacliente = senha;
        Endereco = endereco;
        Descricao = descricao;
    }

}

