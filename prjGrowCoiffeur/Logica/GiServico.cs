using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

// Gereciamento Interno

namespace prjGrowCoiffeur.Logica
{
    public class GiServico : Banco
    {
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
                    Servico servico = new Servico();
                    servico.Codigo = int.Parse(dadosBanco["cd_servico"].ToString());
                    servico.Nome = dadosBanco["nm_servico"].ToString();
                    Categoria categoria = new Categoria();
                    categoria.Codigo = int.Parse(dadosBanco["cd_categoria"].ToString());
                    servico.Categoria = categoria;
                    servicos.Add(servico);
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return servicos;
        }

        public bool AgendarServico(string cliente, int servico, TimeSpan hora, DateTime data, string funcionario)
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