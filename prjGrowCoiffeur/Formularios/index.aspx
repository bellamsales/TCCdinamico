<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="prjGrowCoiffeur.Formularios.inedx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Glow coiffer</title>
    <link rel="shortcut icon" href="images/logo.png" type="image" />
       <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin=""/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="../css/index.css" rel="stylesheet" />      
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <header>
                <img src="../images/logo-branca.png"  id="logobrancaheader"/>
                <ul>
                    <il>
                         <a href="#nossosalao">Nosso salão </a> 
                    </il>
                    <il>
                       <a href="#servicosdeexcelencia"> Serviços de excelencia </a>
                    </il>
                     <il>
                         <a href="#listadiferenciais"> Diferenciais </a>
                    </il>
                    <il> 
                     <asp:Button ID="btnagendar" runat="server" Text="Agende aqui" OnClick="btnagendar_Click" /> 
                    </il>
                 
                </ul>
                
            </header>
                       <main>
                <div id="banner">
                    <img src="../images/banner.png" id="fotobanner" />
                    <h1>
                        <p>Desperte sua beleza interior com o brilho da </p>
                        <p id="titulo">GLOW COIFFEUR</p>
                    </h1>
                    <div id="endereco">
                        <img src="../images/local.png" />
                        <p>Endereço aleatório n°75, Sant Cardoso-SP</p>
                    </div>
                </div>

                <h2>Nosso Salão</h2>
                <div id="nossosalao">
                    <div id="ladoesquerdotexto">
                        <div id="textonossosalao">
                            <p>
                                Bem-vindo ao Beauty Glow, onde cada visita é uma jornada para iluminar sua beleza interior e exterior!
                                Em nosso salão, não apenas transformamos cabelos e unhas, mas também renovamos confianças e elevamos espíritos.
                            </p>
                            <p>
                                No Beauty Glow, acreditamos que a verdadeira beleza reside na confiança e no bem-estar.
                            </p>
                            <p>
                                Nossa equipe de especialistas altamente qualificados está aqui para ajudá-lo a alcançar seus objetivos de beleza,
                                seja através de cortes e cores de cabelo que refletem sua personalidade única, manicures e pedicures que mimam suas mãos e pés.
                            </p>
                            <p>
                                Entre em nosso salão e deixe-se envolver pela atmosfera relaxante e acolhedora.
                            </p>
                        </div>
                    </div>
                    <div id="ladodireito">
                        <img src="../images/imagemnossosalao.png" id="imgnossosalao" />
                    </div>
                </div>

                <div id="paiservicos">
                    <h2>Serviços de excelência</h2>
                    <div id="servicosdeexcelencia">
                        <div class="alinhar">
                            <img src="../images/cortemasc.png" />
                            <p>Corte masculino</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/unha.png" />
                            <p>Unha de fibra</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/cabelo.png" />
                            <p>Relaxamento capilar</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/cabeloloiro.png" />
                            <p>Luzes</p>
                        </div>
                    </div>
                </div>

                <div>
                    <h2>Diferenciais</h2>
                    <div id="listadiferenciais">
                        <div class="alinhar">
                            <img src="../images/boneco (2).png" />
                            <p>Atendimento de Qualidade</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/ambiente.png" />
                            <p>Ambiente acolhedor</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/produtos.png" />
                            <p>Produtos de qualidade</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/tecnologia.jpg" />
                            <p>Tecnologia e Inovação</p>
                        </div>
                        <div class="alinhar">
                            <img src="../images/acessibilidade.png" />
                            <p>Acessibilidade</p>
                        </div>
                    </div>
                </div>
            </main>

            <footer>
                <div id="ladologo">
                    <img src="../images/logo-branca.png" />
                </div>
                <div id="endereco">
                    <img src="../images/local.png" />
                    <p>Endereço aleatório n°75, Sant Cardoso - SP</p>
                </div>
                <div id="redessociais">
                    <img src="../images/instagram.png" />
                    <img src="../images/whatsapp.png" />
                    <img src="../images/facebook.png" />
                </div>
            </footer>
        </div>
    </form>
</body>
</html>