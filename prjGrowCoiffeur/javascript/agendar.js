let diaSelecionado = null;
let funcionarioAG = null;
let dataAG = null;
let servicoAG = null;
let horaAG = null;
let clienteAG = null;
let periodoSelecionado = null;  // Variável para rastrear o período selecionado

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
        selecionarPeriodo('Manhã');
    });
    document.getElementById('btn-tarde').addEventListener('click', function () {
        selecionarPeriodo('Tarde');
    });
    document.getElementById('btn-noite').addEventListener('click', function () {
        selecionarPeriodo('Noite');
    });

    function selecionarPeriodo(periodo) {
        // Remover a classe 'selecionado' de todos os botões de período
        document.getElementById('btn-manha').classList.remove('selecionado');
        document.getElementById('btn-tarde').classList.remove('selecionado');
        document.getElementById('btn-noite').classList.remove('selecionado');

        // Adicionar a classe 'selecionado' ao botão de período atual
        if (periodo === 'Manhã') {
            document.getElementById('btn-manha').classList.add('selecionado');
        } else if (periodo === 'Tarde') {
            document.getElementById('btn-tarde').classList.add('selecionado');
        } else if (periodo === 'Noite') {
            document.getElementById('btn-noite').classList.add('selecionado');
        }

        periodoSelecionado = periodo;  // Atualizar o período selecionado

        // Chamar a função capturarPeriodo para buscar os horários disponíveis
        capturarPeriodo(periodoSelecionado);
    }

    function formatarMinutosParaHoras(minutos) {
        const horas = Math.floor(minutos / 60);
        const minutosRestantes = minutos % 60;

        const horasFormatadas = String(horas).padStart(2, '0');
        const minutosFormatados = String(minutosRestantes).padStart(2, '0');

        return `${horasFormatadas}:${minutosFormatados}`;
    }

    function capturarPeriodo(periodo) {
        if (diaSelecionado === null) return;

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
                    const inicioAlmoco = 12 * 60;
                    const fimAlmoco = 13 * 60;

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

                        // Remover a classe 'selecionado' de todos os botões e adicionar ao atual
                        button.addEventListener('click', function () {
                            const allButtons = document.querySelectorAll('.horario-btn');
                            allButtons.forEach(btn => btn.classList.remove('selecionado'));

                            this.classList.add('selecionado');
                            horaAG = inicioFormatado;
                        });

                        horariosDiv.appendChild(button);

                        inicioMinutos = intervaloFimMinutos;
                        controleDuracao++;
                    }

                    if ((duracaoServico * controleDuracao) > (fimMinutos - inicioMinutosPadrao) && periodo === "Noite")
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
    if (event.target === document.getElementById('errorPopup')) {
        const popup = document.getElementById('errorPopup');
        popup.style.right = '-300px';
        setTimeout(() => {
            popup.style.display = 'none';
        }, 500);
    }
};
