
let diaSelecionado = null;
let funcionarioAG = null;
let dataAG = null;
let servicoAG = null;
let horaAG = null;
let clienteAG = null;
function handleDiaClick(dia, funcionario, mes, servico, cliente, periodos) {
    diaSelecionado = dia;
    funcionarioAG = funcionario;
    clienteAG = cliente;
    servicoAG = servico;

    document.getElementById('btn-manha').disabled = true;
    document.getElementById('btn-tarde').disabled = true;
    document.getElementById('btn-noite').disabled = true;

    const periodosArray = periodos.split(',');
    periodosArray.forEach(periodo => {
        if (periodo === 'Manhã') {
            document.getElementById('btn-manha').disabled = false;
        } else if (periodo === 'Tarde') {
            document.getElementById('btn-tarde').disabled = false;
        } else if (periodo === 'Noite') {
            document.getElementById('btn-noite').disabled = false;
        }
    });

    document.getElementById('btn-manha').addEventListener('click', function () {
        capturarPeriodo('Manhã');
    });
    document.getElementById('btn-tarde').addEventListener('click', function () {
        capturarPeriodo('Tarde');
    });
    document.getElementById('btn-noite').addEventListener('click', function () {
        capturarPeriodo('Noite');
    });


    function formatarMinutosParaHoras(minutos) {
        const horas = Math.floor(minutos / 60);
        const minutosRestantes = minutos % 60;

        const horasFormatadas = String(horas).padStart(2, '0');
        const minutosFormatados = String(minutosRestantes).padStart(2, '0');

        return `${horasFormatadas}:${minutosFormatados}`;
    }

    function capturarPeriodo(periodo) {
        if (diaSelecionado === null)
            return;
        

        const dataSelecionada = new Date(new Date().getFullYear(), mes - 1, diaSelecionado);
        const dataFormatada = dataSelecionada.toISOString().split('T')[0];

        dataAG = dataFormatada;

        const url = `../APIs/ConsultaHoraDisponibilidade.aspx?funcionario=${encodeURIComponent(funcionario)}&data=${encodeURIComponent(dataFormatada)}&periodo=${encodeURIComponent(periodo)}&codigoServico=${encodeURIComponent(servicoAG)}`;
        console.log(url);
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    const errors = [response.status];
                    showPopup(errors);
                    return;
                }
                return response.json();
            })
            .then(data => {

                const horariosDiv = document.getElementById("horariosManha");
                horariosDiv.innerHTML = '';



                data.forEach(d => {
                    let controleDuracao = 0;
                    const duracaoServico = d.TempoServico.TotalMinutes;
                    let inicioMinutosPadrao = d.HoraInicial.TotalMinutes;
                    let inicioMinutos = d.HoraInicial.TotalMinutes;
                    const fimMinutos = d.HoraFinal.TotalMinutes;
                    let bloqueioManha = false;
                    const inicioAlmoco = 12 * 60; // 12:00 em minutos
                    const fimAlmoco = 13 * 60; // 13:00 em minutos

                    if (inicioMinutos <= 12 * 60 && fimMinutos >= 12 * 60) {

                        if (d.HoraInicial.TotalMinutes <= 12 * 60 && d.HoraFinal.TotalMinutes >= 12 * 60)
                            bloqueioManha = true;
                        
                    }
                    while (inicioMinutos < fimMinutos) {
                        let intervaloFimMinutos = inicioMinutos + duracaoServico;

                        if (inicioMinutos < fimAlmoco && intervaloFimMinutos > inicioAlmoco) {

                            if (inicioMinutos < inicioAlmoco)
                                intervaloFimMinutos = inicioAlmoco;
                            else {
                                inicioMinutos = fimAlmoco;
                                continue;
                            }
                        }
                        if (intervaloFimMinutos > fimMinutos)
                            intervaloFimMinutos = fimMinutos;
                        

                        const inicioFormatado = formatarMinutosParaHoras(inicioMinutos);
                        const fimFormatado = formatarMinutosParaHoras(intervaloFimMinutos);

                        const button = document.createElement("button");
                        button.type = "button";
                        button.className = "horario-btn";
                        button.textContent = `${inicioFormatado}`;
                        if (bloqueioManha && inicioMinutos < inicioAlmoco) {
                            document.getElementById('btn-manha').disabled = false;
                        }
                        button.addEventListener('click', function () {
                            if (this.classList.contains('selecionado')) {
                                this.classList.remove('selecionado');
                                horaAG = null;
                            } else {
                                this.classList.add('selecionado');
                                horaAG = inicioFormatado;
                            }
                        });

                        horariosDiv.appendChild(button);

                        inicioMinutos = intervaloFimMinutos;
                        controleDuracao++;
                    }

                    if ((duracaoServico * controleDuracao) > (fimMinutos - inicioMinutosPadrao) && periodo == "Noite")
                        horariosDiv.removeChild(horariosDiv.lastElementChild);
                
                });
            })
            .catch(error => {
                const errors = [error];
                showPopup(errors);
                return;
            });
    }
}
function agendarServico() {

    const url = `../APIs/AgendarServicoAPI.aspx?funcionario=${encodeURIComponent(funcionarioAG)}&cliente=${encodeURIComponent(clienteAG)}&servico=${encodeURIComponent(servicoAG)}&data=${encodeURIComponent(dataAG)}&hora=${encodeURIComponent(horaAG)}`;
    console.log(url);

    fetch(url)
        .then(response => {
            if (!response.ok) {
                const errors = [response.status];
                showPopup(errors);
                return;
            }
            return response.json();
        })
        .then(data => {
            const errors = [data.message || data.error];
            showPopup(errors);
        })
        .catch(error => {
            const errors = [error];
            showPopup(errors);
        });

}

const periodoButtons = document.querySelectorAll('.periodo-btn');


periodoButtons.forEach(button => {
    button.addEventListener('click', function () {

        if (this.classList.contains('selecionado')) {

            this.classList.remove('selecionado');

        } else {

            periodoButtons.forEach(btn => btn.classList.remove('selecionado'));


            this.classList.add('selecionado');

        }
    });
});


function showPopup(errors) {
    const popup = document.getElementById('errorPopup');
    popup.style.display = 'block';
    popup.style.right = '0';


    document.getElementById('errorMessages').innerHTML = errors.join('<br>');


    setTimeout(() => {
        popup.style.right = '-300px';
        setTimeout(() => {
            popup.style.display = 'none';
        }, 500);
    }, 3000);
}
document.querySelector('.close').onclick = function () {
    const popup = document.getElementById('errorPopup');
    popup.style.right = '-300px';
    setTimeout(() => {
        popup.style.display = 'none';
    }, 500);
};

window.onclick = function (event) {
    if (event.target == document.getElementById('errorPopup')) {
        const popup = document.getElementById('errorPopup');
        popup.style.right = '-300px';
        setTimeout(() => {
            popup.style.display = 'none';
        }, 500);
    }
};