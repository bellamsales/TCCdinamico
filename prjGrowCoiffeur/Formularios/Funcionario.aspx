<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="funcionario.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.funcionario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="css/funcionario.css">
    <link href="../css/estilofuncionario.css" rel="stylesheet" />
    <link href="../css/menu.css" rel="stylesheet" />
    <title>Funcionários</title>
</head>
<body>
    <form id="form1" runat="server">
        

      <div>
                 <nav class="menu-lateral"> 
            <div class="btn-expandir">
                <i class="bi bi-caret-left-fill" id="btn-exp"></i>
            </div>

            <a href="index.html">
                <img src="../images/logo-branca.png" alt="Logo" class="logo" />
            </a>
            <ul>
                <li class="item-menu">
                    <a href="index.html">
                        <span class="icon"><i class="bi bi-calendar-date"></i></span>
                        <span class="txt-link">Agenda</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
                <li class="item-menu">
                                <a href="funcionario.aspx">
                                    <span class="icon"><i class="bi bi-people"></i></span>
                                    <span class="txt-link">Funcionário</span>
                                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                                </a>
                </li>
                <li class="item-menu ativo">
                    <a href="produto.aspx">
                        <span class="icon"><i class="bi bi-archive"></i></span>
                        <span class="txt-link">Produto</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>

                <li class="item-menu">
                    <a href="servico.html">
                        <span class="icon"><i class="bi bi-scissors"></i></span>
                        <span class="txt-link">Serviço</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
                <li class="item-menu">
                    <a href="feedback.html">
                        <span class="icon"><i class="bi bi-star-fill"></i></span>
                        <span class="txt-link">Feedback</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
                <li class="item-menu">
                    <a href="cliente.html">
                        <span class="icon"><i class="bi bi-person"></i></span>
                        <span class="txt-link">Cliente</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
           
            </ul>
        </nav>



           <div class="funcio">
        <h1>Funcionário(a)</h1>
        <div class="container">
            <div class="lista-funcionarios">
                <div class="search-bar">
                    <input type="text" placeholder="Pesquisar">
                    <i class="bi bi-search"></i>
                </div>
                <div class="funcionario" id="funcionario1">
                    <span>Nome: Renato <br> Tintura, Esmaltação</span>
                </div>
                <div class="funcionario" id="funcionario2">
                    <span>Nome: Renato <br> Luzes, Unha de Fibra</span>
                </div>
                <div class="funcionario" id="funcionario3">
                    <span>Nome: Luzia <br> Escova, Botox</span>
                </div>
                <div class="funcionario" id="funcionario4">
                    <span>Nome: Amanda <br> SPA das mãos, Esmaltação</span>
                </div>
            </div>

            <div class="detalhes-funcionario">
                <h2>Nome: Luzia Vasconcelos de Almeida</h2>
                <p>Email: luziaprofissional@gmail.com</p>
                <h3>Serviços :</h3>
                <ul>
                    <li>Botox - 1 hora e 20 minutos <span>R$200,00</span></li>
                    <li>Prancha - 30 minutos <span>R$100,00</span></li>
                    <li>Escova - 30 min <span>R$50,00</span></li>
                </ul>
            </div>
        </div>
    </div>






















    </form>
</body>
</html>
