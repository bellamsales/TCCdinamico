using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Servico
    {
        public int Codigo { get; set; }
        public string Nome { get; set; }
        public string Descrição { get; set; }
        public double ValorMonetario { get; set; }
        public TimeSpan TempoEstimado { get; set; }
        public Categoria Categoria { get; set; }



    }   
}