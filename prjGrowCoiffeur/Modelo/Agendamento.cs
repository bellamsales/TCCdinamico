using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Modelo
{
    public class Agendamento : Banco

    {
        public TimeSpan HoraAgendamento { get; set; }
        public Servico Servico { get; set; }
        public Cliente Cliente { get; set; }
        public Funcionario Funcionario { get; set; }
        public int Codigo { get; set; }
        public DateTime DataAgendamento { get; set; }


        public bool Agendar(string cliente, int servico, TimeSpan hora, DateTime data, string funcionario)
        {
            List<Parametro> parametros = new List<Parametro>
            {
                new Parametro("pCliente", cliente),
                new Parametro("pServico", servico.ToString()),
                new Parametro("pHora", hora.ToString()),
                new Parametro("pData", data.ToString("yyyy-MM-dd")), 
                new Parametro("pFuncionario", funcionario)
            };

            try
            {
                Conectar();
                Executar("AgendarServico", parametros);
                Desconectar();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }
    }
}