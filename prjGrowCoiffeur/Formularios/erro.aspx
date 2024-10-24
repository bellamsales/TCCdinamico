<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="erro.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.erro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Erro!</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../css/erro.css" />
</head>
    <body>
    <form id="form1" runat="server">
         <img src="../images/floresquerda.png" alt="Flores" class="floresquerda" />
        <div class="container">
            <div class="logo-flores">
                <img src="../images/logo.png" alt="Logo" class="logo" />
            </div>
            <div class="error-message">
                <h1>Ocorreu um erro!</h1>
                <p>Desculpe, houve um problema ao processar sua solicitação. Tente novamente mais tarde.</p>
            </div>
            <asp:Button ID="btnVoltar" runat="server" OnClick="btnVoltar_Click" Text="Voltar à Página Inicial" CssClass="btn-voltar" />
        </div>
        <img src="../images/flordireita.png" alt="Flores" class="flordireita" />
    </form>
</body>
</html>
