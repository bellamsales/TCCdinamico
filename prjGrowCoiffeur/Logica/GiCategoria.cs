using MySql.Data.MySqlClient;
using prjGrowCoiffeur.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

// Gereciamento Interno

namespace prjGrowCoiffeur.Logica
{
    public class GiCategoria : Banco
    {
        public List<Categoria> ConsultarCategorias()
        {
            List<Categoria> categorias = new List<Categoria>();
            List<Parametro> parametros = new List<Parametro>();
                MySqlDataReader dadosBanco = Consultar("ConsultarCategorias", parametros);
                if (dadosBanco.HasRows)
                {
                    while (dadosBanco.Read())
                    {
                        Categoria categoria = new Categoria();
                        categoria.Codigo = int.Parse(dadosBanco["cd_categoria"].ToString());
                        categoria.Nome = dadosBanco["nm_categoria"].ToString();
                        categorias.Add(categoria);
                    }
                }
                if (!dadosBanco.IsClosed)
                    dadosBanco.Close();
                Desconectar();
            return categorias;
        }

        public Categoria ConsultarCategoriaPorServico(int codigoServico)
        {
            Categoria categoria = null;
            List<Parametro> parametros = new List<Parametro>();
            Parametro parametro = new Parametro("p_cd_servico", codigoServico.ToString());
            parametros.Add(parametro);

            MySqlDataReader dadosBanco = Consultar("ConsultarCategoriaPorServico", parametros);
            if (dadosBanco.HasRows)
            {
                while (dadosBanco.Read())
                {
                    categoria = new Categoria
                    {
                        Codigo = int.Parse(dadosBanco["cd_categoria"].ToString()),
                        Nome = dadosBanco["nm_categoria"].ToString() 
                    };
                }
            }
            if (!dadosBanco.IsClosed)
                dadosBanco.Close();
            Desconectar();
            return categoria;
        }
    }
}