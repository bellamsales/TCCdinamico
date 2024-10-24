<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Servico.aspx.cs" Inherits="prjGrowCoiffeur.Servico" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/servico.css">
    <link rel="stylesheet" href="../css/menu.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <title>Serviço</title>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="menu-lateral">
        <div class="btn-expandir">
            <i class="bi bi-caret-left-fill" id="btn-exp"></i>
        </div>

        <a href="index.aspx">
            <img src="../images/logo-branca.png" alt="Logo" class="logo">
           
        </a>
        <ul>
            <li class="item-menu">
                <a href="index.aspx">
                    <span class="icon"><i class="bi bi-calendar-date"></i></span>
                    <span class="txt-link">Agenda</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
            <li class="item-menu">
                <a href="funcionario.aspx">
                    <span class="icon"><i class="bi bi-people"></i></span>
                    <span class="txt-link">Funcionario</span>
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

            <li class="item-menu ativo">
                <a href="servico.aspx">
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
                <a href="cliente.aspx">
                    <span class="icon"><i class="bi bi-person"></i></span>
                    <span class="txt-link">Cliente</span>
                    <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                </a>
            </li>
        </ul>
    </nav>

    <div class="contaier">
        <div class="conteudo">
            <h1>Serviços</h1>
            <div class="categoria-servico">
                <div class="categoria">
                    <div class="cabecalho-categoria">
                        <h2>Cabelo</h2>
                        <div class="icones">
                            <i class="bi bi-pencil"></i>
                            <i class="bi bi-plus"></i>
                        </div>
                    </div>




                    <asp:Literal ID="LitCabelo" runat="server"></asp:Literal>


                    <ul class="servicos">
                        <li>
                            <i class="bi bi-trash"></i>
                            <span>Corte</span>
                            <i class="bi bi-pencil-square"></i>
                        </li>
                        <li>
                            <i class="bi bi-trash"></i>
                            <span>Tinta</span>
                            <i class="bi bi-pencil-square"></i>
                        </li>
                    </ul>
                    
                </div>
    
                <div class="categoria">
                    <div class="cabecalho-categoria">
                        <h2>Unha</h2>

                        
                        <asp:Literal ID="LitUnha" runat="server"></asp:Literal>


                        <div class="icones">
                            <i class="bi bi-pencil"></i>
                            <i class="bi bi-plus"></i>
                        </div>
                    </div>
                    <ul class="servicos">
                        <li>
                            <span>Esmaltação</span>
                            <i class="bi bi-trash"></i>
                            <i class="bi bi-pencil"></i>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
        <script src="../javascript/servico.js"></script>  
        <script src="../javascript/menu.js"></script>

    </form>


</body>
</html>
