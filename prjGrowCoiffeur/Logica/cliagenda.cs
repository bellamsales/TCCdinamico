using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


    public class cliagenda :Banco
    {
    public List<Agendamento> ConsultarAgendamentosPorCliente(string emailCliente)
    {
        List<Agendamento> agendamentos = new List<Agendamento>();
        List<Parametro> parametros = new List<Parametro>();

        // Adicionando o parâmetro do email do cliente
        parametros.Add(new Parametro("p_nm_email_cliente", emailCliente));

        // Executando a consulta
        MySqlDataReader dadosBanco = Consultar("ConsultarAgendamentosPorCliente", parametros);

        if (dadosBanco.HasRows)
        {
            while (dadosBanco.Read())
            {
                
                Agendamento agendamento = new Agendamento();

                // Preenchendo os dados do agendamento
                agendamento.Codigo = Convert.ToInt32(dadosBanco["cd_agendamento"]);
                agendamento.DataAgendamento = Convert.ToDateTime(dadosBanco["dt_agendamento"]);
                agendamento.HoraAgendamento = TimeSpan.Parse(dadosBanco["hr_agendamento"].ToString());

                // Preenchendo dados do funcionário
                Funcionario funcionario = new Funcionario();
                funcionario.Nome = dadosBanco["nm_funcionario"].ToString();
                agendamento.Funcionario = funcionario;

                // Preenchendo dados do serviço
                Servico servico = new Servico();
                servico.Nome = dadosBanco["nm_servico"].ToString();
                agendamento.Servico = servico;

                // Adicionando o agendamento à lista
                agendamentos.Add(agendamento);
            }
        }

        // Fechando o DataReader e desconectando do banco de dados
        if (!dadosBanco.IsClosed)
            dadosBanco.Close();
        Desconectar();

        // Retornando a lista de agendamentos
        return agendamentos;
    }
}
