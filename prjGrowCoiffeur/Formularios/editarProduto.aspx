ot
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarProduto.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.editarProduto" %>

<!DOCTYPE html>
<html lang="pt-br"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
    rel="stylesheet">
    <link rel="stylesheet" href="../css/editarproduto.css">
    <link rel="stylesheet" href="../css/menu.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <title>Editar produto</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <nav class="menu-lateral">
        <div class="btn-expandir">
            <i class="bi bi-caret-left-fill" id="btn-exp"></i>
        </div>

        <a href="entrada.html">
            <img src="../images/logo-branca.png" alt="Logo" class="logo">
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
     <div class="conteudo">
        <header>
            <a href="produto.aspx">
                <i class="bi bi-chevron-double-left" id="voltar"></i>
            </a>

            <h1>Editar Produto</h1>

        </header>
       <%-- <div class="blocomaior">
            <div class="ladoesquerdo">
                <div class="espacamento">
                    <label> Nome </label>
                    <select name="selectproduto" id="selectprodutos">
                        <option>Shampoo Cachos</option>
                        <option>Condicionador</option>
                        <option>Creme para Pentear</option>
                        <option>Sahmpoo Masculino</option>
                        <option>salon line</option>
                    </select>
                </div>

                <div class="espacamento">
                    <label>
                        Marca
                    </label>
                    <select name="selectmarca" id="selectmarcas">
                        <option>loreal</option>
                        <option>salon line</option>
                        <option>salon line</option>
                        <option>salon line</option>
                        <option>salon line</option>
                        <option>salon line</option>
                    </select>
                </div>

                <div class="espacamento">
                    <label>
                        Categoria
                    </label>
                    <select name="selectservico" class="selectservicos">
                        <option>Hidratação</option>
                        <option>Corte masculino</option>
                        <option>Hidratação capilar</option>
                        <option>Alongamento</option>
                        <option>Tintura</option>
                        <option>Esmaltação</option>
                    </select>
                </div>

            </div>
            <div class="ladodireito">
                <div class="espacamento">
                    <label>
                        Validade
                    </label>
                    <input class="data-selecionada" type="date" id="diaa" value="2019-04-23" id="data" name="diaa" />
                </div>
                <div class="espacamento">
                    <label>
                        Serviço:
                    </label>
                    <select name="selectservico" class="selectservicos">
                        <option>Corte feminimo</option>
                        <option>Corte masculino</option>
                        <option>Hidratação capilar</option>
                        <option>Alongamento</option>
                        <option>Tintura</option>
                        <option>Esmaltação</option>
                    </select>
                </div>

            </div>
        </div>--%>
       <%-- <div class="btns">
            <a href="produto.html">
                <button id="btnexcluir">Excluir produto</button>
                <button id="btnedit">Editar produto</button>
            </a>
        </div>
    </div>--%>
          <section class="areaFormulario">
     <p>
         <label for="txtCodigo">Código:</label>
         <asp:TextBox ID="txtCodigo" runat="server" placeholder="Aqui deve ser o código" disabled></asp:TextBox>
     </p>

     <p>
         <label for="txtNome">Nome:</label>
         <asp:TextBox ID="txtNome" runat="server" placeholder="Informe Nome do Produto"  autofocus></asp:TextBox>
     </p>

     <p>
         <label for="txtPreco">Preço:</label>
         <asp:TextBox ID="txtPreco" runat="server" placeholder="Informe valor unitário" ></asp:TextBox>
     </p>
      <p>
     <label for="txtmarca">Marca:</label>
     <asp:TextBox ID="txtmarca" runat="server" placeholder="infome a marca do produto" ></asp:TextBox>
      </p>
      <p>
       <label for="txtdata">Data:</label>
       <asp:TextBox ID="txtdata" runat="server" placeholder="infome a data do produto" ></asp:TextBox>
      </p>
      <p>
         <label for="txtquantidadenoestoque">Quantidade no estoque:</label>
         <asp:TextBox ID="txtquantidadenoestoque" runat="server" placeholder="infome a data do produto" ></asp:TextBox>
      </p>
       <p  class="btns">
            
                     <asp:Button ID="btnexcluir" runat="server" OnClick="btnexcluir_Click" Text="Excluir Produto" />
                     <asp:Button ID="btnedit" runat="server" OnClick="btnedit_Click" Text="Editar produto" />
       </p>
     <div class="rodape">
    <asp:Literal ID="litMsg" runat="server"></asp:Literal>
    <%--<h2 class="aviso erro">Código Inválido</h2>--%>
    </div>
<%-- 
     <p> <%--  <asp:Button ID="btnSalvar" CssClass="botao" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /> </p>--%>
     
              


 </section>

    <script src="javascript/menu.js"></script>
        </div>
    </form>
</body>
</html>
