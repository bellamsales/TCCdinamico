<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Agendar.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.Agendar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet"/>
    <title>Glow Coiffeur</title>
    <link rel="stylesheet" href="../css/agendar.css"/>
    
    <% if (Session["TipoUsuario"] != null) { %>
       <% if (Session["TipoUsuario"].ToString() == "funcionario" || Session["TipoUsuario"].ToString() == "gerente") { %>
            <link rel="stylesheet" href="../css/menuFuncionario.css"/>
        <% } else { %>
            <link rel="stylesheet" href="../css/menu.css"/>
        <% } %>
    <% } else { %>
        <link rel="stylesheet" href="../css/menu.css"/>
    <% } %>
</head>
<body>
    <form id="form1" runat="server">
        <% if (Session["TipoUsuario"] != null) { %>
           <% if (Session["TipoUsuario"].ToString() == "funcionario" || Session["TipoUsuario"].ToString() == "gerente") { %>
                <nav class="menu-lateral">
                    <div class="btn-expandir">
                        <i class="bi bi-caret-left-fill" id="btn-exp"></i>
                    </div>
                    <a href="index.aspx">
                        <img src="../images/logo-branca.png" alt="Logo" class="logo" />
                    </a>
                    <ul>
                           <li class="item-menu">
                       <a href="Agendamentos.aspx">
                        <span class="icon"><i class="bi bi-table"></i></span>
                        <span class="txt-link">Agendar</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
            <li class="item-menu ativo">
                    <a href="Agendar.aspx">
                        <span class="icon"><i class="bi bi-calendar-date"></i></span>
                        <span class="txt-link">Planilha</span>
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
                        <a href="ListarClientes.aspx">
                            <span class="icon"><i class="bi bi-person"></i></span>
                            <span class="txt-link">Cliente</span>
                            <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                        </a>
                    </li>

                        <li class="item-menu" id="logout">
                            <a href="index.aspx">
                                <span class="icon"><i class="bi bi-box-arrow-left"></i></span>
                                <span class="txt-link">Sair</span>
                                <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                            </a>
                        </li>
                    </ul>
                </nav>
            <% } else { %>
                <nav class="menu-lateral">
                    <div class="btn-expandir">
                        <i class="bi bi-caret-left-fill" id="btn-exp"></i>
                    </div>
                    <a href="index.aspx">
                        <img src="../images/logo-branca.png" alt="Logo" class="logo" />
                    </a>
                    <ul>
                        <li class="item-menu ativo">
                            <a href="meusAgendamentos.aspx">
                                <span class="icon"><i class="bi bi-calendar-check"></i></span>
                                <span class="txt-link">Agenda</span>
                                <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                            </a>
                        </li>
                     
            <li class="item-menu">
                    <a href="Agendar.aspx">
                        <span class="icon"><i class="bi bi-calendar-date"></i></span>
                        <span class="txt-link">Planilha</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
                               
                      
                        <li class="item-menu" id="logout">
                            <a href="index.aspx">
                                <span class="icon"><i class="bi bi-box-arrow-left"></i></span>
                                <span class="txt-link">Sair</span>
                                <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                            </a>
                        </li>
                    </ul>
                </nav>
            <% } %>
        <% } %>


               <div class="conteudo">
                

    <div id="errorPopup" class="popup">
        <div class="popup-content">
            <span class="close">&times;</span>
            <h2>Sistema:</h2>
            <p id="errorMessages">Aqui aparecem os erros de HTML e CSS.</p>
        </div>
    </div>
            <h1><strong>Novo agendamento</strong></h1>
            <asp:Panel ID="pnlCliente" CssClass="form-group" Visible="false" runat="server">
                <label for="txtCliente">Email do Cliente:</label>
                <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
            </asp:Panel>

            <div class="form-group">
                <label for="ddlcategoriaServico">Categorias:</label>
                <asp:DropDownList ID="ddlcategoriaServico" runat="server" OnSelectedIndexChanged="ddlservico_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlservico">Serviço:</label>
                <asp:DropDownList ID="ddlservico" runat="server" OnSelectedIndexChanged="ddlservico_SelectedIndexChanged1" AutoPostBack="true"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlprofissional">Selecionar profissional:</label>
                <asp:DropDownList ID="ddlprofissional" runat="server" AutoPostBack="true"></asp:DropDownList>
            </div>

            <label for="horario">Selecionar dia e horário:</label>
            <div class="calendar">

               
                <asp:DropDownList ID="cmbMeses" runat="server" OnSelectedIndexChanged="cmbMeses_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                <div id="calendario">
                    <asp:Literal ID="litDias" runat="server"></asp:Literal>
                </div>
                 <h3 id="dia-da-semana"></h3>
            </div>
                   <div class="mensagem-disponibilidade">
    <p>*Os dias que possuem a cor roxa estão disponíveis, os que não possuem estão indisponíveis.</p>
</div>
            <div class="calendario">
                <div class="dias">
                    <button type="button" id="btn-manha" class="periodo-btn" data-periodo="Manhã" disabled="">Manhã</button>
                    <button type="button" id="btn-tarde" class="periodo-btn" data-periodo="Tarde" disabled="">Tarde</button>
                    <button type="button" id="btn-noite" class="periodo-btn" data-periodo="Noite" disabled="">Noite</button>
                </div>
                <div class="horarios" id="horarios" runat="server"></div>
            </div>

            <div id="containerHorarios" class="horarios">
    <div id="horariosManha" class="horarios-lista">
        <!-- Botões de horários disponíveis aparecerão aqui -->
    </div>
    <div id="horariosTarde" class="horarios-lista">
        <!-- Botões de horários disponíveis aparecerão aqui -->
    </div>
    <div id="horariosNoite" class="horarios-lista">
        <!-- Botões de horários disponíveis aparecerão aqui -->
    </div>
</div>

            <button type="button" class="agendar" onclick="agendarServico()">Agendar Serviço</button>
        </div>
    </form>

    <script src="../javascript/agendar.js"></script>
    <script src="../javascript/menu.js"></script>
</body>
</html>