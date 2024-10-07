<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cadastro.aspx.cs" Inherits="TCC_GLOW_COIFFEUR.Cadastro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <title>Glow Coiffeur</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../css/cadastro.css" />
</head>
<body>
    <form id="form1" runat="server">
        <img src="../images/floresquerda.png" alt="Flores" class="floresquerda" />
        <div class="container">
            <h1>Bem-vindo ao Glow Coiffeur!</h1>
            <div class="form-group">
                <label for="nome">Nome:</label>
                <asp:TextBox ID="Txtnome" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <asp:TextBox ID="txtsenha" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <asp:Button ID="btn" runat="server" Text="Cadastrar-se" OnClick="btn_Click" CssClass="btn btn-primary" />
            <p class="login">
                <asp:Literal ID="litmensage" runat="server"></asp:Literal>
            </p>
           <p class="login">
           Já tem uma conta?&nbsp;<a href="login.aspx" class="aLogin">Login</a>
            </p>
            <div class="logo">
                <img src="../images/logo.png" alt="Logo" class="logo" />
            </div>
        </div>
        <img src="../images/flordireita.png" alt="Flores" class="flordireita" />
    </form>
</body>
</html>