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

        public List<Agendamento> ConsultarHorariosAgendamentos(string emailFuncionario, DateTime dataAgendamento, int codServico)
        {
            List<Agendamento> agendamentos = new List<Agendamento>();
            List<Parametro> parametros = new List<Parametro>();

            parametros.Add(new Parametro("p_email_funcionario", emailFuncionario));

            parametros.Add(new Parametro("p_data_agendamento", dataAgendamento.ToString("yyyy-MM-dd")));

            MySqlDataReader dadosBanco = Consultar("ConsultarHorariosAgendamentos", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Agendamento agendamento = new Agendamento();
                    Servico servico = new Servico();
                    servico.TempoEstimado = (TimeSpan)dadosBanco["qt_tempo_servico"];
                    agendamento.Servico = servico;
                    agendamento.HoraAgendamento = TimeSpan.Parse(dadosBanco["hr_agendamento"].ToString());

                    agendamentos.Add(agendamento);
                }
            }

            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();

            return agendamentos;
        }
        public List<Disponibilidade> FiltrarHorariosDisponiveis(string emailFuncionario, DateTime data, string periodo, int codigoServico)
        {
            List<Disponibilidade> disponibilidades = new GiFuncionarios().ConsultarHoraDisponibilidadeFuncionario(emailFuncionario, data, periodo, codigoServico);

            List<Agendamento> agendamentos = ConsultarHorariosAgendamentos(emailFuncionario, data, codigoServico);

            List<Disponibilidade> horariosFiltrados = new List<Disponibilidade>();

            foreach (var disponibilidade in disponibilidades)
            {
                List<Disponibilidade> intervalosDisponiveis = new List<Disponibilidade> { disponibilidade };

                foreach (var agendamento in agendamentos)
                {
                    List<Disponibilidade> novosIntervalos = new List<Disponibilidade>();

                    foreach (var intervalo in intervalosDisponiveis)
                    {
                        if (agendamento.HoraAgendamento >= intervalo.HoraInicial && agendamento.HoraAgendamento < intervalo.HoraFinal)
                        {
                            if (agendamento.HoraAgendamento > intervalo.HoraInicial)
                            {
                                novosIntervalos.Add(new Disponibilidade
                                {
                                    HoraInicial = intervalo.HoraInicial,
                                    HoraFinal = agendamento.HoraAgendamento,
                                    TempoServico = intervalo.TempoServico
                                });
                            }

                            TimeSpan novaHoraInicial = agendamento.HoraAgendamento + agendamento.Servico.TempoEstimado;
                            if (novaHoraInicial < intervalo.HoraFinal)
                            {
                                novosIntervalos.Add(new Disponibilidade
                                {
                                    HoraInicial = novaHoraInicial,
                                    HoraFinal = intervalo.HoraFinal,
                                    TempoServico = intervalo.TempoServico
                                });
                            }
                        }
                        else
                            novosIntervalos.Add(intervalo);
                    }

                    intervalosDisponiveis = novosIntervalos;
                }

                horariosFiltrados.AddRange(intervalosDisponiveis);
            }

            return horariosFiltrados;
        }

        public List<Agendamento> ConsultarAgendamentosPorData(DateTime dataAgendamento)
        {
            List<Agendamento> agendamentos = new List<Agendamento>();
            List<Parametro> parametros = new List<Parametro>();

            // Adiciona o parâmetro de data à lista de parâmetros
            parametros.Add(new Parametro("p_dt_agendamento", dataAgendamento.ToString("yyyy-MM-dd")));

            // Chama a stored procedure
            MySqlDataReader dadosBanco = Consultar("ConsultarAgendamentosPorData", parametros);

            // Lê os dados retornados pela stored procedure
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Agendamento agendamento = new Agendamento
                    {
                        HoraAgendamento = TimeSpan.Parse(dadosBanco["hr_agendamento"].ToString()),
                        Servico = new Servico
                        {
                            Nome = dadosBanco["nm_servico"].ToString()
                        },
                        Cliente = new Cliente
                        {
                            Nome = dadosBanco["nm_cliente"].ToString()
                        },
                        Funcionario = new Funcionario
                        {
                            Nome = dadosBanco["nm_funcionario"].ToString()
                        }
                    };
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