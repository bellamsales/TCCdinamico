<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarClientes.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.ListarClientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
         <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="../css/cliente.css"/>
        <link rel="stylesheet" href="../css/menu.css"/>
        <meta charset="UTF-8" />
        <link rel="shortcut icon" href="../images/logo.png" type="image" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
        <title>Cliente</title>
</head>
<body>
    <form id="form1" runat="server">
            <div>
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
            <li class="item-menu">
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
                <li class="item-menu ativo">
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
           
                <li class="item-menu ativo">
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
            </ul>
        </nav>
         <div class="conteudo">
           <header>
               <h1><strong> Clientes </strong></h1>
                <asp:Button ID="btnaddcliente" runat="server" Text="Adicionar Cliente" OnClick="btnaddcliente_Click" />
           </header>
           <section class="listadeclientes">
             <div class="caixaclientea">
                 <asp:Literal ID="litcliente" runat="server"></asp:Literal>
             </div>
           </section>
        </div>
     <script src="../javascript/menu.js"></script>    
            </div>
    </form>
</body>
</html>
