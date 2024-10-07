using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Funcionario
    {
        public string Email { get; set; }
        public string Nome { get; set; }
        public string Telefone { get; set; }
        public string Endereco { get; set; }
        public Servico Especialidade { get; set; }

    }
}