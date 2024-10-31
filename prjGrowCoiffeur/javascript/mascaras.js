function mascaraTelefone(telefone) {
    
    let valor = telefone.value.replace(/\D/g, '');
    
    if (valor.length > 6) {
        telefone.value = valor.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else if (valor.length > 2) {
        telefone.value = valor.replace(/(\d{2})(\d{4})/, '($1) $2');
    } else {
        telefone.value = valor;
    }
}