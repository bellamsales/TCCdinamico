<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarFuncionario.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.editarFuncionario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head runat="server">


    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" 
    rel="stylesheet" />
    <link rel="stylesheet" href="../css/editarcliente.css"/>
    <link rel="stylesheet" href="../css/menu.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <title>Editar Funcionário</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
                <li class="item-menu ativo">
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
        <div class="conteudo">
   <header>
       <a href="Funcionario.aspx">
           <i class="bi bi-chevron-double-left" id="voltar"></i>
       </a>

       <h1>Editar Funcionário</h1>

   </header>
              <section class="areaFormulario">
     

     <p>
         <label for="txtNome">Nome:</label>
         <asp:TextBox ID="txtNome" runat="server" placeholder="Informe o Nome do Funcionário"  autofocus=""></asp:TextBox>
     </p>

     <p>
         <label for="txtEmail">Email:</label>
         <asp:TextBox ID="txtEmail" runat="server" placeholder="Informe o Email do Funcionário" ></asp:TextBox>
     </p>

     <p>
         <label for="txtSenha">Senha:</label>
         <asp:TextBox ID="txtSenha" runat="server" placeholder="Informe a senha do Funcionário" MaxLength="8" ReadOnly="true"></asp:TextBox>
     </p>

      <p>
    <label for="txtTelefone">Telefone:</label>
    <asp:TextBox ID="txtTelefone" runat="server"              
                 placeholder="Informe o telefone completo, incluindo o DDD" 
                 onkeyup="mascaraTelefone(event)"></asp:TextBox>
</p>

     <p>
         <label for="txtEndereco">Endereço:</label>
         <asp:TextBox ID="txtEndereco" runat="server" placeholder="Informe o Endereço do Funcionário" ></asp:TextBox>
     </p>
      <p>
     <label for="txtCargo">Cargo:</label>
     <asp:TextBox ID="txtCargo" runat="server" placeholder="Informe o Cargo do Funcionário" ></asp:TextBox>
      </p>
       <p  class="btns">
            
                     <asp:Button ID="btnexcluir" runat="server" OnClick="btnexcluir_Click" Text="Excluir Funcionário" OnClientClick="return confirm('Tem certeza que deseja excluir este funcionário?');" />
                     <asp:Button ID="btnedit" runat="server" OnClick="btnedit_Click" Text=" Editar Funcionário" />
       </p>
     <div class="rodape">
    <asp:Literal ID="litMsg" runat="server"></asp:Literal>
    <%--<h2 class="aviso erro">Código Inválido</h2>--%>
    </div>
<%-- 
     <p> <%--  <asp:Button ID="btnSalvar" CssClass="botao" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /> </p>--%>
     
              


 </section>

    <script src="javascript/menu.js"></script>
            <script src="javascript/mascaras.js"></script>
            <script src="../javascript/senha.js"></script>
        </div>
    </form>
</body>
</html>

