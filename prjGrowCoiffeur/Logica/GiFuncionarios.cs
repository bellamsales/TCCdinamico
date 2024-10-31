using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Data;
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

        public List<Disponibilidade> ConsultarHoraDisponibilidadeFuncionario(
        string funcionario, DateTime data, string periodo, int codigoServico)
        {
            string dataMySQL = data.ToString("yyyy-MM-dd");
            List<Disponibilidade> disponibilidades = new List<Disponibilidade>();

            List<Parametro> parametros = new List<Parametro>
            {
                new Parametro("p_email_funcionario", funcionario),
                new Parametro("p_data_disponibilidade", dataMySQL),
                new Parametro("p_periodo_disponibilidade", periodo),
                new Parametro("p_codigo_servico", codigoServico.ToString())
            };

            MySqlDataReader dadosBanco = Consultar("BuscarDisponibilidade", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Disponibilidade disp = new Disponibilidade
                    {
                        HoraInicial = (TimeSpan)dadosBanco["hr_inicio_disponibilidade"],
                        HoraFinal = (TimeSpan)dadosBanco["hr_fim_disponibilidade"],
                        TempoServico = (TimeSpan)dadosBanco["qt_tempo_servico"]
                    };
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
                    Funcionario funcionario = new Funcionario
                    {
                        Nome = dadosBanco["nm_funcionario"].ToString(),
                        Email = dadosBanco["nm_email_funcionario"].ToString(),
                        Telefone = FormatarTelefone(dadosBanco["nm_telefone"].ToString()),
                        Endereco = dadosBanco["nm_endereco"].ToString(),
                        Cargo = dadosBanco["nm_cargo"].ToString(),
                        CPF = dadosBanco["nm_cpf"].ToString(),
                      
                    };
                    funcionarios.Add(funcionario);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return funcionarios;
        }

        public List<string> ObterHorariosOcupados(string funcionario, DateTime data)
        {
            List<string> horariosOcupados = new List<string>();
            string dataMySQL = data.ToString("yyyy-MM-dd");

            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_funcionario", funcionario);
            Parametro parametro2 = new Parametro("p_data", dataMySQL);
            parametros.Add(parametro);
            parametros.Add(parametro2);

            MySqlDataReader dadosBanco = Consultar("ConsultarHorariosOcupados", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {

                    horariosOcupados.Add(dadosBanco["horario_ocupado"].ToString());
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return horariosOcupados;
        }


        public List<string> ObterHorariosDisponiveis(int duracao, List<string> horariosOcupados)
        {
            var horariosDisponiveis = new List<string>();
            TimeSpan inicioManha = new TimeSpan(8, 0, 0);
            TimeSpan fimAlmoco = new TimeSpan(12, 0, 0);
            TimeSpan inicioTarde = new TimeSpan(13, 0, 0);
            TimeSpan fimTarde = new TimeSpan(17, 30, 0);
            TimeSpan inicioNoite = new TimeSpan(18, 0, 0);
            TimeSpan fimNoite = new TimeSpan(20, 0, 0);

            // Manhã
            for (TimeSpan hora = inicioManha; hora < fimAlmoco; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")) &&
                    ((duracao == 30 && hora + TimeSpan.FromMinutes(30) <= fimAlmoco) ||
                     (duracao == 60 && hora + TimeSpan.FromMinutes(60) <= fimAlmoco) ||
                     (duracao == 120 && hora + TimeSpan.FromMinutes(120) <= fimAlmoco)))
                {
                    horariosDisponiveis.Add(hora.ToString(@"hh\:mm"));
                }
            }

            // Tarde
            for (TimeSpan hora = inicioTarde; hora < fimTarde; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")))
                {
                    horariosDisponiveis.Add(hora.ToString(@"hh\:mm"));
                }
            }

            // Noite
            for (TimeSpan hora = inicioNoite; hora < fimNoite; hora = hora.Add(TimeSpan.FromMinutes(30)))
            {
                if (!horariosOcupados.Contains(hora.ToString(@"hh\:mm")))
                {
                    horariosDisponiveis.Add(hora.ToString(@"hh\:mm"));
                }
            }

            return horariosDisponiveis;
        }

        public List<Disponibilidade> ConsultarPeriodoDisponivel(string emailFuncionario)
        {
            List<Disponibilidade> periodosDisponiveis = new List<Disponibilidade>();
            List<Parametro> parametros = new List<Parametro>();

            parametros.Add(new Parametro("pEmail", emailFuncionario));

            MySqlDataReader dadosBanco = Consultar("ConsultarPeriodoDisponivel", parametros);

            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Disponibilidade periodo = new Disponibilidade();
                    periodo.NomePeriodo = dadosBanco["nm_periodo_disponibilidade"].ToString();
                    periodosDisponiveis.Add(periodo);
                }
            }

            if (!dadosBanco.IsClosed)
                dadosBanco.Close();

            Desconectar();

            return periodosDisponiveis;
        }

        public Funcionario BuscarDadosFuncionario(string emailFuncionario)
        {
            Funcionario funcionario = null;
            try
            {
                List<Parametro> parametros = new List<Parametro>
    {
        new Parametro("p_nm_email_funcionario", emailFuncionario)
    };

                MySqlDataReader dados = Consultar("ConsultarFuncionarioPorEmail", parametros);

                if (dados.Read())
                {
                    funcionario = new Funcionario
                    {
                        Email = dados.GetString(0),                 
                        Nome = dados.GetString(1),                 
                        Telefone = FormatarTelefone(dados.GetString(2)), 
                        Endereco = dados.GetString(3),             
                        Cargo = dados.GetString(4),                 
                        CPF = dados.GetString(5)
                    };
                }

                if (dados != null && !dados.IsClosed)
                {
                    dados.Close();
                }
                Desconectar();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao buscar dados do Funcionário: " + ex.Message);
            }
            return funcionario;
        }



        public List<Funcionario> Listar()
        {
            List<Funcionario> funcionarios = new List<Funcionario>();

            MySqlDataReader dadosBanco = Consultar("ConsultarFuncionarios", null);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    Funcionario funcionario = new Funcionario
                    {
                        Nome = dadosBanco["nm_funcionario"].ToString(),
                        Email = dadosBanco["nm_email_funcionario"].ToString(),
                        Telefone = FormatarTelefone(dadosBanco["nm_telefone"].ToString()),
                        Endereco = dadosBanco["nm_endereco"].ToString(),
                        Cargo = dadosBanco["nm_cargo"].ToString(),
                        CPF = dadosBanco["nm_cpf"].ToString(),
                        Ativo = dadosBanco["ativo"] != DBNull.Value && Convert.ToBoolean(dadosBanco["ativo"]) 
                    };
                    funcionarios.Add(funcionario);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return funcionarios;
        }
            private string FormatarTelefone(string telefone)
        {
            
            var numeros = new string(telefone.Where(char.IsDigit).ToArray());

            if (numeros.Length == 11) 
            {
                return $"({numeros.Substring(0, 2)}) {numeros.Substring(2, 5)}-{numeros.Substring(7)}";
            }
            else if (numeros.Length == 10) 
            {
                return $"({numeros.Substring(0, 2)}) {numeros.Substring(2, 4)}-{numeros.Substring(6)}";
            }
            return telefone; 
        }

        public bool FuncionarioInativo(string email)
        {
            List<Parametro> parametros = new List<Parametro>
            {
                new Parametro("p_nm_email_funcionario", email)
            };

            try
            {
                Conectar();
                Executar("FuncionarioInativo", parametros);
                Desconectar();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao inativar o funcionário: " + ex.Message);
            }
        }

        public bool AdicionarFuncionario(string nome, string email, string senha, string telefone, string endereco, string cargo, string cpf)
        {
            List<Parametro> parametros = new List<Parametro>
        {
            new Parametro("p_nm_funcionario", nome),
            new Parametro("p_nm_email_funcionario", email),
            new Parametro("p_nm_senha", senha),
            new Parametro("p_nm_telefone", telefone),
            new Parametro("p_nm_endereco", endereco),
            new Parametro("p_nm_cargo", cargo),
            new Parametro("p_nm_CPF", cpf),

        };

            try
            {
                Conectar();
                Executar("InserirFuncionario", parametros);
                Desconectar();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

            public bool EmailExiste(string email)
        {
            using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Funcionario WHERE nm_email_funcionario = @p_email", conn);
                cmd.Parameters.AddWithValue("@p_email", email);

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0; 
            }
        }


        public bool EditarFuncionario(string emailAtual, string novoEmail, Funcionario funcionario, int CdFuncionario)
        {
            try
            {
                
                Conectar();

                if (!EmailExiste(emailAtual))
                {
                    throw new Exception("O funcionário não existe.");
                }

    
                List<Parametro> parametros = new List<Parametro>
        {
                 new Parametro("p_nm_email_funcionario", emailAtual),
                 new Parametro("p_nm_novo_email", novoEmail),
                 new Parametro("p_nm_funcionario", funcionario.Nome),
                 new Parametro("p_nm_senha", funcionario.Senha),
                 new Parametro("p_nm_telefone", funcionario.Telefone),
                 new Parametro("p_nm_endereco", funcionario.Endereco),
                 new Parametro("p_nm_cargo", funcionario.Cargo),

        };

                Executar("AtualizarFuncionario", parametros);
                Desconectar();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
            public bool ExcluirFuncionario(string email)
        {
           
            if (FuncionarioTemAgendamentos(email))
            {
                try
                {
                    List<Parametro> parametros = new List<Parametro>
            {
                new Parametro("p_nm_email_funcionario", email)
            };
                   
                    Conectar();
                    Executar("FuncionarioInativo", parametros);
                    Desconectar();
                    return false; 
                }
                catch (Exception ex)
                {
                    throw new Exception("Erro ao inativar funcionário: " + ex.Message);
                }
            }

          
            List<Parametro> parametrosDelete = new List<Parametro>
    {
        new Parametro("p_nm_email_funcionario", email)
    };

            try
            {
               
                Conectar();
                Executar("ExcluirFuncionario", parametrosDelete);
                Desconectar();
                return true; 
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao excluir funcionário: " + ex.Message);
            }
        }


        public bool FuncionarioTemAgendamentos(string email)
        {
            using (MySqlConnection conn = new MySqlConnection("SERVER=localhost;UID=root;PASSWORD=root;DATABASE=bancotcc04"))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("FuncionarioTemAgendamentos", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@p_email", email);
                MySqlParameter countParam = new MySqlParameter("@p_count", MySqlDbType.Int32)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(countParam);

                cmd.ExecuteNonQuery();

                int count = Convert.ToInt32(countParam.Value);
                return count > 0;
            }
        }



    }

}

    
