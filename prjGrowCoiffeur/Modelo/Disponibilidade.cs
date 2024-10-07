using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Disponibilidade
    {
        public Funcionario Funcionario { get; set; }
        public DateTime Data { get; set; }
        public TimeSpan HoraFinal { get; set; }
        public TimeSpan HoraInicial { get; set; }

    }
}