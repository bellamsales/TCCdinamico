using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Agendamento
    {
        public TimeSpan HoraAgendamento { get; set; }
        public Servico Servico { get; set; }
        public Cliente Cliente { get; set; }
        public Funcionario Funcionario { get; set; }
    }
}