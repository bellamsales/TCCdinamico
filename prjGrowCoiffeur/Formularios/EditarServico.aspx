<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarServico.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.EditarServico" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin=""/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
    rel="stylesheet"/>
    <link rel="stylesheet" href="../css/editarproduto.css"/>
    <link rel="stylesheet" href="../css/menu.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <title>Editar Servico</title>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="menu-lateral">
                <div class="btn-expandir">
                    <i class="bi bi-caret-left-fill" id="btn-exp"></i>
                </div>
                <a href="index.aspx">
                    <img src="../images/logo-branca.png" alt="Logo" class="logo" />
                </a>
                <ul>
                    <li class="item-menu"><a href="Agendamentos.aspx"><span class="icon"><i class="bi bi-table"></i></span><span class="txt-link">Agendar</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu"><a href="Agendar.aspx"><span class="icon"><i class="bi bi-calendar-date"></i></span><span class="txt-link">Planilha</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu"><a href="funcionario.aspx"><span class="icon"><i class="bi bi-people"></i></span><span class="txt-link">Funcionário</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu "><a href="produto.aspx"><span class="icon"><i class="bi bi-archive"></i></span><span class="txt-link">Produto</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu ativo"><a href="servico.aspx"><span class="icon"><i class="bi bi-scissors"></i></span><span class="txt-link">Serviço</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu"><a href="ListarClientes.aspx"><span class="icon"><i class="bi bi-person"></i></span><span class="txt-link">Cliente</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>
                    <li class="item-menu" id="logout"> <a href="index.aspx"><span class="icon"><i class="bi bi-box-arrow-left"></i></span><span class="txt-link">Sair</span><span class="icon-seta"><i class="bi bi-caret-right"></i></span></a></li>                  
                </ul>
            </nav>
            <div class="conteudo">
                <header>
                    <a href="Servico.aspx">
                        <i class="bi bi-chevron-double-left" id="voltar"></i>
                    </a>
                    <h1>Editar Serviço</h1>
                </header>
                <section class="areaFormulario">
                    <p>
                        <label for="txtCodigo">Código:</label>
                        <asp:TextBox ID="txtCodigo" runat="server" placeholder="Digite o código do serviço" Disabled="" ReadOnly="true"></asp:TextBox>
                    </p>

                    <p>
                        <label for="txtNome">Nome:</label>
                        <asp:TextBox ID="txtNome" runat="server" placeholder="Informe nome do serviço" autofocus=""></asp:TextBox>
                    </p>

                    <p>
                        <label for="txtPreco">Preço:</label>
                        <asp:TextBox ID="txtPreco" runat="server" placeholder="Informe valor unitário do serviço"></asp:TextBox>
                    </p>
                    
                    <p>
                        <label for="txtdata">Tempo de Serviço:</label>
                        <asp:TextBox ID="txtTempo" runat="server" placeholder="Informe a data do serviço"></asp:TextBox>
                    </p>

                    <p>
                        <label for="txtdata">Descrição do Serviço:</label>
                        <asp:TextBox ID="txtDescricao" runat="server" placeholder="Informe a descrição do serviço"></asp:TextBox>
                    </p>
                    
                        <asp:Button ID="btnSalvar" Text="Salvar" runat="server" OnClick="btnSalvar_Click"/>
                    
                    <div class="rodape">
                        <asp:Literal ID="litMsg" runat="server"></asp:Literal>
                    </div>
                </section>
                <script src="javascript/menu.js"></script>
            </div>
    </form>
</body>
</html>
