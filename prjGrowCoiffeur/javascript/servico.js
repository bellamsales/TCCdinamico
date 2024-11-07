function adicionarServico(categoria) {
    const novaLI = document.createElement('li');
    novaLI.innerHTML = `<span>Novo Serviço</span><i class="bi bi-trash"></i><i class="bi bi-pencil"></i>`;
    document.querySelector(`.categoria:contains(${categoria}) .servicos`).appendChild(novaLI);
}

document.querySelectorAll('.bi-plus').forEach(button => {
    button.addEventListener('click', function() {
        const categoria = this.closest('.categoria').querySelector('h2').innerText;
        adicionarServico(categoria);
    });
});