<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Agendar.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.Agendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet"/>
    <title>Glow Coiffeur</title>
    <link rel="stylesheet" href="../css/agendar.css"/>
    <link rel="stylesheet" href="../css/menu.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="menu-lateral"> 
        <div class="btn-expandir">
            <i class="bi bi-caret-left-fill" id="btn-exp"></i>
        </div>
        <a href="index.html">
            <img src="../imagens/logo-branca.png" alt="Logo" class="logo">
        </a>
        <ul>
            <li class="item-menu ativo">
                <a href="agendar.aspx">
                    <span class="icon"><i class="bi bi-calendar-date"></i></span>
                    <span class="txt-link">Agenda</span>
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

            <li class="item-menu" id="logout">
                <a href="#">
                    <span class="icon"><i class="bi bi-box-arrow-left"></i></span>
                    <span class="txt-link">Sair</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
        </ul>
    </nav>

    <div class="conteudo">
        <h1><strong>Novo agendamento</strong></h1>
        <form>
            <asp:Panel ID="pnlCliente" CssClass="form-group" Visible="false" runat="server">
                <label for="Cliente">Email do Cliente:</label>
                <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
            </asp:Panel>
            <div class="form-group">
                <label for="servico">Tipo do Serviço:</label>
                <asp:DropDownList ID="ddlcategoriaServico"  runat="server" OnSelectedIndexChanged="ddlservico_SelectedIndexChanged"  AutoPostBack="true"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="servico">Serviço:</label>
                <asp:DropDownList ID="ddlservico" runat="server" OnSelectedIndexChanged="ddlservico_SelectedIndexChanged1" AutoPostBack="true"></asp:DropDownList>
            </div>
            
            <div class="form-group">
                <label for="profissional">Selecionar profissional:</label>
                <asp:DropDownList ID="ddlprofissional" runat="server"  AutoPostBack="true"></asp:DropDownList>
            </div>

            <label for="horario">Selecionar dia e horário::</label>
            <div class="calendar">
                <asp:DropDownList ID="cmbMeses" runat="server" OnSelectedIndexChanged="cmbMeses_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                <div id="calendario">
                    <asp:Literal ID="litDias" runat="server"></asp:Literal>
                </div>
            </div>
            <div class="calendario">
                <div class="dias">
                    <button type="button" id="btn-manha" class="periodo-btn" data-periodo="Manhã" disabled>Manhã</button>
                    <button type="button" id="btn-tarde" class="periodo-btn" data-periodo="Tarde" disabled>Tarde</button>
                    <button type="button" id="btn-noite" class="periodo-btn" data-periodo="Noite" disabled>Noite</button>
                </div>
                <div class="horarios" id="horarios"></div>
            </div>
            
            <div id="containerHorarios" class="horarios">
    
                <div id="horariosManha" class="horarios-lista">
                    <!-- Os botões de horário serão adicionados aqui -->
                </div>
                <div id="horariosTarde" class="horarios-lista">
                    <!-- Os botões de horário da tarde podem ser adicionados aqui se necessário -->
                </div>
                <div id="horariosNoite" class="horarios-lista">
                    <!-- Os botões de horário da noite podem ser adicionados aqui se necessário -->
                </div>
            </div>

                <button type="button" class="agendar" onclick="agendarServico()">Agendar Serviço</button>
            </div>
        </form>
    </div>
    <script src="../javascript/agendar.js"></script>
    <script src="../javascript/menu.js"></script>
    </form>
</body>
</html>
