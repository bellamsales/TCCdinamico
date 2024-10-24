<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Agendamentos.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.Agendamentos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
  
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
      
      <title>Glow Coiffeur</title>
    <link rel="stylesheet" href="../css/menu.css" />
    <%--<link rel="stylesheet" href="../css/agendar.css"/>--%>
    <link rel="stylesheet" href="../css/index.css" />
</head>
<body>
    <form id="form1" runat="server">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <nav class="menu-lateral"> 
        <div class="btn-expandir">
            <i class="bi bi-caret-left-fill" id="btn-exp"></i>
        </div>

        <a href="agendamento.aspx">
            <img src="../images/logo-branca.png" alt="Logo" class="logo" />
        </a>
        <ul>
            <li class="item-menu ativo">
                <a href="agendamento.aspx">
                    <span class="icon"><i class="bi bi-calendar-date"></i></span>
                    <span class="txt-link">Agenda</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
            <li class="item-menu">
                            <a href="funcionario.html">
                                <span class="icon"><i class="bi bi-people"></i></span>
                                <span class="txt-link">Funcionário</span>
                                <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                            </a>
            </li>
            <li class="item-menu">
                <a href="produto.aspx">
                    <span class="icon"><i class="bi bi-archive"></i></span>
                    <span class="txt-link">Produto</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>

            <li class="item-menu">
                <a href="servico.aspx">
                    <span class="icon"><i class="bi bi-scissors"></i></span>
                    <span class="txt-link">Serviço</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
            <li class="item-menu">
                <a href="feedback.aspx">
                    <span class="icon"><i class="bi bi-star-fill"></i></span>
                    <span class="txt-link">Feedback</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
            <li class="item-menu">
                <a href="cliente.aspx">
                    <span class="icon"><i class="bi bi-person"></i></span>
                    <span class="txt-link">Cliente</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
           
        </ul>
        <button>
            
        </button>
    </nav>

<div class="conteudo">
    <header>
        <div class="form-group">
            <asp:DropDownList ID="ddlFuncionarios" runat="server" OnSelectedIndexChanged="ddlFuncionarios_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
        </div>
        <asp:Button ID="btnagendar" runat="server" PostBackUrl="Agendar.aspx" Text="Agendar" />

        <%--<button id="btnagendar" onclick="window.location.href='Agendar.aspx';">Agendar</button>--%>
    </header>
    <div class="principal-calendario">
        <div class="container-data">
            <div class="seletor-data">
                 <!--<button class="botao-nav">&#8249;</button>-->
                <asp:TextBox ID="txtDataAgendamento" runat="server" TextMode="Date" OnTextChanged="txtDataAgendamento_TextChanged" AutoPostBack="True" />

                <%--<input class="data-selecionada" type="date" id="diaa" value="2019-04-23" id="data" name="diaa" runat="server" />--%>
                 <!--<button class="botao-nav">&#8250;</button>-->
            </div>
        </div>
        <div class="grade-calendario">
            <div class="coluna-horarios">
                <!-- Horários de 30 em 30 minutos -->
                <div class="faixa-horario">08:00</div>
                <div class="faixa-horario">08:30</div>
                <div class="faixa-horario">09:00</div>
                <div class="faixa-horario">09:30</div>
                <div class="faixa-horario">10:00</div>
                <div class="faixa-horario">10:30</div>
                <div class="faixa-horario">11:00</div>
                <div class="faixa-horario">11:30</div>
                <div class="faixa-horario">13:00</div>
                <div class="faixa-horario">13:30</div>
                <div class="faixa-horario">14:00</div>
                <div class="faixa-horario">14:30</div>
                <div class="faixa-horario">15:00</div>
                <div class="faixa-horario">15:30</div>
                <div class="faixa-horario">16:00</div>
                <div class="faixa-horario">16:30</div>
                <div class="faixa-horario">17:00</div>
                <div class="faixa-horario">17:30</div>
                <div class="faixa-horario">18:00</div>
                <div class="faixa-horario">18:30</div>
                <div class="faixa-horario">19:00</div>
                <div class="faixa-horario">19:30</div>
                <div class="faixa-horario">20:00</div>
            </div>
            <div class="coluna-compromissos">
                <!-- Blocos de agendamento -->
                <asp:Literal ID="litCompromissos" runat="server"></asp:Literal>
                <%--<div class="compromisso">Corte de Cabelo-Ana Clara</div>
                
                <div class="compromisso-vazio"></div>
                <div class="compromisso">Corte de Cabelo-Ana Clara</div>--%>
            </div>
        </div>
    </div>
    <script src="script.js"></script>
   
    <script src="javascript/menu.js"></script>
    <script src="javascript/agendar.js"></script>
    </form>
</body>
</html>
