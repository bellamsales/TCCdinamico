<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginFuncionario.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.LoginFuncionario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login do Funcionário</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../css/loginFuncionario.css" />
</head>
<body>
    <form id="form1" runat="server">
         <img src="../images/floresquerda.png" alt="Flores" class="floresquerda" />
    <div class="container">
        <div class="logo-flores">
            <img src="../images/logo.png" alt="Logo" class="logo" />
        </div>

            <label for="email">Email:</label>
            <%--<input type="email" id="email" name="email" required>--%>
            <asp:TextBox ID="txtEmail" TextMode="email" runat="server" required=""></asp:TextBox>

            <label for="senha">Senha:</label>
            <%--<input type="password" id="senha" name="senha" required>--%>
            <asp:TextBox ID="txtSenha" TextMode="password" maxlength="8"  runat="server"></asp:TextBox>
        <asp:Label ID="lblMensagem" runat="server" Text="" ForeColor="red"></asp:Label>


            <p>Não tem uma conta? <a href="cadastro.aspx">Crie uma conta</a></p>
            <%--<button type="submit"><a href="entrada.html" class="aEntrada"> Entrar </a></button>--%>
        <asp:Button ID="btnEntrar" runat="server" OnClick="btnEntrar_Click" Text="Entrar" />
      
    </div>
    <img src="../images/flordireita.png" alt="Flores" class="flordireita" />
        </form>
</body>
</html>

