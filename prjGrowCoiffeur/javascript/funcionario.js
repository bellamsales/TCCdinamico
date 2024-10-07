document.querySelectorAll('.funcionario').forEach(funcionario => {
    funcionario.addEventListener('click', function() {
        let nome = this.querySelector('span').innerHTML.split('<br>')[0];
        let servicos = this.querySelector('span').innerHTML.split('<br>')[1];

        document.querySelector('.detalhes-funcionario h2').textContent = nome;
        document.querySelector('.detalhes-funcionario ul').innerHTML = 
            `<li>${servicos} <span>Valor a definir</span></li>`;
    });
});
