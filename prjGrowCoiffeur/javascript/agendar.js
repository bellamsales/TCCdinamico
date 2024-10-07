//var menuItem = document.querySelectorAll('.item-menu');

//async function fetchAppointments() {
//    const response = await fetch('/api/appointments');
//    const appointments = await response.json();

//    const appointmentTemplate = document.getElementById('appointmentTemplate');
//    const agendaContainer = document.querySelector('.agenda');
//    agendaContainer.innerHTML = '';

//    appointments.forEach(appointment => {
//        const appointmentElement = appointmentTemplate.content.cloneNode(true);
//        appointmentElement.querySelector('.cliente').textContent = `Cliente: ${appointment.cliente}`;
//        appointmentElement.querySelector('.servico').textContent = `Serviço: ${appointment.servico}`;
//        appointmentElement.querySelector('.data').textContent = `Data: ${appointment.data}`;
//        appointmentElement.querySelector('.horario').textContent = `Horário: ${appointment.horario}`;
//        agendaContainer.appendChild(appointmentElement);
//    });
//}
//window.onload = fetchAppointments;

//const caixaMes = document.getElementById('cmbMeses');
//if (caixaMes)
//caixaMes.addEventListener('change', function(e){
//gerarCalendario(caixaMes.value, 2024);
//})

//function gerarCalendario(mes, ano) {

//// cria uma data com o ano e mes especificado. O terceiro parametro seria o dia, colocando 0 ele assume o ultimo dia do mes
//const diasNoMes = new Date(ano, mes + 1, 0).getDate();

//// cria uma data com o ano e mes especificado. No caso, o primeiro dia do mes. com getDay pegamos o dia da semana (0 = domingo, 6 = sábado)
//const primeiroDia = new Date(ano, mes, 1).getDay();
//console.log(primeiroDia);

//const calendario = document.getElementById('calendario');
//calendario.innerHTML = '';

//const datasPredefinidas = [5, 10, 15, 25]; // Dias marcados de exemplo

//if (primeiroDia < 6)
//{
//for (let i = 0; i < primeiroDia; i++) {
//    const celulaVazia = document.createElement('div');
//    celulaVazia.className = 'dia vazio';
//    calendario.appendChild(celulaVazia);
//}
//}


//for (let dia = 1; dia <= diasNoMes; dia++) {
//const diaElemento = document.createElement('div');
//diaElemento.className = 'dia';
//diaElemento.textContent = dia;

//if (datasPredefinidas.includes(dia)) {
//    diaElemento.classList.add('predefinido');
//}

//calendario.appendChild(diaElemento);
//}
//}

//gerarCalendario(5, 2024); // Meses começam em 0 (Janeiro = 0, Agosto = 7)

//document.addEventListener("DOMContentLoaded", function() {
//    const form = document.querySelector('form');
//    form.addEventListener('submit', function(event) {
//        event.preventDefault();


//        const nomeCliente = document.getElementById('nomeCliente').value;
//        const emailCliente = document.getElementById('emailCliente').value;
//        const servico = document.getElementById('servico').value;
//        const profissional = document.getElementById('profissional').value;
//        const horario = document.querySelector('input[name="horario"]:checked').value;


//        const novoAgendamento = {
//            cliente: nomeCliente,
//            email: emailCliente,
//            servico: servico,
//            profissional: profissional,
//            horario: horario
//        };


//        const agendamentos = JSON.parse(localStorage.getItem('agendamentos')) || [];


//        agendamentos.push(novoAgendamento);


//        localStorage.setItem('agendamentos', JSON.stringify(agendamentos));


//        window.location.href = 'index.html';
//    });
// });
let diaSelecionado = null;
let funcionarioAG = null;
let dataAG = null;
let servicoAG = null;
let horaAG = null;
let clienteAG = null;

function handleDiaClick(dia, funcionario, mes, servico, cliente) {
    diaSelecionado = dia;
    funcionarioAG = funcionario;
    clienteAG = cliente;
    servicoAG = servico; // pode ser null ou um valor de serviço
    document.getElementById('btn-manha').disabled = false;
    document.getElementById('btn-tarde').disabled = false;
    document.getElementById('btn-noite').disabled = false;

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
        if (diaSelecionado === null) {
            return;
        }

        const dataSelecionada = new Date(new Date().getFullYear(), mes - 1, diaSelecionado);
        const dataFormatada = dataSelecionada.toISOString().split('T')[0];
        dataAG = dataFormatada;

        const url = `../APIs/ConsultaHoraDisponibilidade.aspx?funcionario=${encodeURIComponent(funcionario)}&data=${encodeURIComponent(dataFormatada)}&periodo=${encodeURIComponent(periodo)}`;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na requisição: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log(data);
                const horariosDiv = document.getElementById("horariosManha");
                horariosDiv.innerHTML = '';

                data.forEach(d => {
                    const button = document.createElement("button");
                    button.type = "button";
                    button.className = "horario-btn";
                    button.textContent = `${formatarMinutosParaHoras(d.HoraInicial.TotalMinutes)} - ${formatarMinutosParaHoras(d.HoraFinal.TotalMinutes)}`;

                    button.addEventListener('click', function () {
                        if (this.classList.contains('selecionado')) {
                            this.classList.remove('selecionado');
                            horaAG = null;
                        } else {
                            this.classList.add('selecionado');
                            horaAG = formatarMinutosParaHoras(d.HoraInicial.TotalMinutes);
                        }
                    });

                    horariosDiv.appendChild(button);
                });
            })
            .catch(error => {
                console.error('Erro:', error);
            });
    }
}

function agendarServico() {
    
    const servicoParam = servicoAG ? encodeURIComponent(servicoAG) : '0';
    const url = `../APIs/AgendarServicoAPI.aspx?funcionario=${encodeURIComponent(funcionarioAG)}&cliente=${encodeURIComponent(clienteAG)}&servico=${servicoParam}&data=${encodeURIComponent(dataAG)}&hora=${encodeURIComponent(horaAG)}`;
    console.log(url);

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            alert(data.message || data.error);
        })
        .catch(error => {
            console.error('Erro:', error);
            alert('Erro ao agendar o serviço. Tente novamente.');
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