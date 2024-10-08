using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace prjGrowCoiffeur.Logica
{
    public class GiFuncionarios : Banco
    {
        public List<Funcionario> ConsultarFuncionariosPorServico(int codigo)
        {
            List<Funcionario> funcionarios = new List<Funcionario>();
            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_cd_servico", codigo.ToString());
            parametros.Add(parametro);

            MySqlDataReader dadosBanco = Consultar("ConsultarFuncionariosPorServico", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Funcionario funcionario = new Funcionario();
                    funcionario.Email = dadosBanco["nm_email_funcionario"].ToString();
                    funcionario.Nome = dadosBanco["nm_funcionario"].ToString();
                    Servico servico = new Servico();
                    servico.Codigo = int.Parse(dadosBanco["cd_servico"].ToString());
                    funcionario.Especialidade = servico;
                    funcionarios.Add(funcionario);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return funcionarios;
        }

        public List<Disponibilidade> ConsultarDisponibilidadeFuncionario(string funcionario)
        {
            List<Disponibilidade> disponibilidades = new List<Disponibilidade>();
            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_funcionario", funcionario);
            parametros.Add(parametro);

            MySqlDataReader dadosBanco = Consultar("ConsultarDataDisponibilidadeFuncionario", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Disponibilidade disp = new Disponibilidade();
                    disp.Data = (DateTime)dadosBanco["dt_inicio_disponibilidade"];
                    disponibilidades.Add(disp);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return disponibilidades;
        }

        public List<Disponibilidade> ConsultarHoraDisponibilidadeFuncionario(string funcionario, DateTime data, string periodo)
        {
            string dataMySQL = data.ToString("yyyy-MM-dd");
            List<Disponibilidade> disponibilidades = new List<Disponibilidade>();
            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_funcionario", funcionario);
            Parametro parametro2 = new Parametro("p_data", dataMySQL);
            Parametro parametro3 = new Parametro("p_periodo", periodo);
            parametros.Add(parametro);
            parametros.Add(parametro2);
            parametros.Add(parametro3);

            MySqlDataReader dadosBanco = Consultar("ConsultarHoraDisponibilidadeFuncionario", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Disponibilidade disp = new Disponibilidade();
                    disp.HoraInicial = (TimeSpan)dadosBanco["hr_inicio_disponibilidade"];
                    disp.HoraFinal = (TimeSpan)dadosBanco["hr_fim_disponibilidade"];
                    disponibilidades.Add(disp);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return disponibilidades;
        }

        public List<Funcionario> ConsultarFuncionarios()
        {
            List<Funcionario> funcionarios = new List<Funcionario>();


            MySqlDataReader dadosBanco = Consultar("ConsultarFuncionarios", null);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Funcionario funcionario = new Funcionario();
                    funcionario.Nome = dadosBanco["nm_funcionario"].ToString();
                    funcionario.Email = dadosBanco["nm_email_funcionario"].ToString();
                    funcionarios.Add(funcionario);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return funcionarios;
        }


    }
}