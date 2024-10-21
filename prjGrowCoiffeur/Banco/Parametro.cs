using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Parametro
{
    public string Nome { get; set; }
    public object Valor { get; set; }  

    public Parametro(string nome, object valor)  
    {
        Nome = nome;
        Valor = valor;
    }
}