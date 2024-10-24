using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

// Gereciamento Interno

namespace prjGrowCoiffeur.Logica
{
    public class GiServico : Banco
    {
        private string connectionString = "server=localhost;database=your_database_name;user=your_username;password=your_password;";

        public List<Servico> ConsultarServicosPorCategoria(int codigo)
        {
            List<Servico> servicos = new List<Servico>();
            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_cd_categoria", codigo.ToString());
            parametros.Add(parametro);

            MySqlDataReader dadosBanco = Consultar("ConsultarServicosPorCategoria", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    //Servico servico = new Servico
                    //{
                    //    Codigo = int.Parse(dadosBanco["cd_servico"].ToString()),
                    //    Nome = dadosBanco["nm_servico"].ToString(),
                    //    Categoria = new Categoria
                    //    {
                    //        Codigo = int.Parse(dadosBanco["cd_categoria"].ToString())
                    //    }
                    //};
                    //servicos.Add(servico);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return servicos;
        }

        public bool AgendarServico(string cliente, int servico, TimeSpan hora, DateTime data, string funcionario)
        {
            // Obtenha a duração do serviço (em minutos)
            TimeSpan duracao = ObterDuracaoServico(servico);
            if (duracao == TimeSpan.Zero)
            {
                throw new Exception("Duração do serviço inválida.");
            }

            // Preencha os horários ocupados para o funcionário
            List<string> horariosOcupados = ObterHorariosOcupados(funcionario, data);

            // Verifique se os horários necessários estão disponíveis
            for (int i = 0; i < duracao.TotalMinutes / 30; i++) // Assumindo que cada incremento é de 30 minutos
            {
                TimeSpan horarioOcupado = hora.Add(TimeSpan.FromMinutes(30 * i));
                if (horariosOcupados.Contains(horarioOcupado.ToString(@"hh\:mm")))
                {
                    // Se o horário já estiver ocupado, retorne false
                    return false;
                }
            }

            // Se todos os horários necessários estiverem disponíveis, faça o agendamento
            return InserirAgendamento(cliente, servico, hora, data, funcionario);
        }

        private bool InserirAgendamento(string cliente, int servico, TimeSpan hora, DateTime data, string funcionario)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    string query = "INSERT INTO Agendamentos (Cliente, Servico, Hora, Data, Funcionario) VALUES (@Cliente, @Servico, @Hora, @Data, @Funcionario)";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Cliente", cliente);
                        cmd.Parameters.AddWithValue("@Servico", servico);
                        cmd.Parameters.AddWithValue("@Hora", hora);
                        cmd.Parameters.AddWithValue("@Data", data.Date);
                        cmd.Parameters.AddWithValue("@Funcionario", funcionario);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0; // Retorna true se a inserção foi bem-sucedida
                    }
                }
            }
            catch (Exception ex)
            {
                // Aqui você pode fazer log da exceção
                Console.WriteLine("Erro ao inserir agendamento: " + ex.Message);
                return false; // Retorne falso em caso de erro
            }
        }

        private TimeSpan ObterDuracaoServico(int servico)
        {
            TimeSpan duracao = TimeSpan.Zero;

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    using (MySqlCommand cmd = new MySqlCommand("ObterDuracaoServico", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServicoId", servico);
                        MySqlParameter duracaoParam = new MySqlParameter("@Duracao", MySqlDbType.Time)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(duracaoParam);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Obtém o valor de duração do parâmetro de saída
                        duracao = (TimeSpan)duracaoParam.Value;
                    }
                }
            }
            catch (Exception ex)
            {
                // Aqui você pode fazer log da exceção
                Console.WriteLine("Erro ao obter duração do serviço: " + ex.Message);
            }

            return duracao; // Retorna a duração do serviço
        }

        private List<string> ObterHorariosOcupados(string funcionario, DateTime data)
        {
            List<string> horariosOcupados = new List<string>();

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    string query = "SELECT Hora FROM Agendamentos WHERE Funcionario = @Funcionario AND Data = @Data";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Funcionario", funcionario);
                        cmd.Parameters.AddWithValue("@Data", data.Date); // Certifique-se de comparar somente a parte da data

                        conn.Open();
                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // Adiciona os horários ocupados à lista
                                horariosOcupados.Add(reader["Hora"].ToString());
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Aqui você pode fazer log da exceção
                Console.WriteLine("Erro ao obter horários ocupados: " + ex.Message);
            }

            return horariosOcupados;
        }
    }
}