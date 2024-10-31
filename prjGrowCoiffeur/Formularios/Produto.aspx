<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Produto.aspx.cs" Inherits="prjGrowCoiffeur.Produto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
         <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="../css/produto.css"/>
        <link rel="stylesheet" href="../css/menu.css"/>
        <meta charset="UTF-8" />
        <link rel="shortcut icon" href="../images/logo.png" type="image" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
        <title>Produto</title>
   
    </head>
<body>
        <form id="form1" runat="server">
            <asp:Literal ID="litTeste" runat="server"></asp:Literal>
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
                    <a href="ListarClientes.aspx">
                        <span class="icon"><i class="bi bi-person"></i></span>
                        <span class="txt-link">Cliente</span>
                        <span class="icon-seta"><i class="bi bi-caret-right"></i></span>
                    </a>
                </li>
           
            </ul>
        </nav>
         <div class="conteudo">
           <header>
            <div id="divBusca">
                <input type="text" id="txtBusca" placeholder="Buscar..."/>
                <img src="../images/procurar.png" id="btnBusca" alt="Buscar"/>
                  </div>  
                   <asp:Button ID="btnaddproduto" runat="server" OnClick="btnaddproduto_Click" Text="Adicionar Produto" />
                 
           </header>
           <section class="listadeprodutos">
             <div class="caixaprodutos">
                 <asp:Literal ID="litProdutos" runat="server" />
                 <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                
    
                 <%--   <p><strong>Categoria :</strong> <asp:Literal ID="litcategoriaproduto" runat="server"></asp:Literal></p>--%>
           
                
                 
           
             </div>
           </section>
           
        </div>
       
     <script src="../javascript/menu.js"></script>    
            </div>

        </form>
    </body>
    </html>
