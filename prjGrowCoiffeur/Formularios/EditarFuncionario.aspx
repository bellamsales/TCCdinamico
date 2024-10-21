<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarFuncionario.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.EditarFuncionario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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

    </form>
</body>
</html>
