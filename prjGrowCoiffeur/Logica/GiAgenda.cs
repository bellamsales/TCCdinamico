using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Formularios;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Logica
{
    public class GiAgenda : Banco
    {
        public List<Agendamento> ConsultarAgendamentosPorFuncionarioData(string emailFuncionario, DateTime dataAgendamento)
        {
            List<Agendamento> agendamentos = new List<Agendamento>();
            List<Parametro> parametros = new List<Parametro>();

           
            parametros.Add(new Parametro("p_funcionario_email", emailFuncionario));
            parametros.Add(new Parametro("p_data_agendamento", dataAgendamento.ToString("yyyy-MM-dd")));

            MySqlDataReader dadosBanco = Consultar("ConsultarAgendamentosPorFuncionarioData", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Agendamento agendamento = new Agendamento();

                    agendamento.HoraAgendamento = TimeSpan.Parse(dadosBanco["hr_agendamento"].ToString());

                    Servico servico = new Servico();
                    servico.Nome = dadosBanco["nm_servico"].ToString();
                    agendamento.Servico = servico;

                    Cliente cliente = new Cliente();
                    cliente.Nome = dadosBanco["nm_cliente"].ToString();
                    agendamento.Cliente = cliente;
                    agendamentos.Add(agendamento);
                }
            }

            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();

            return agendamentos;
        }
    }
}