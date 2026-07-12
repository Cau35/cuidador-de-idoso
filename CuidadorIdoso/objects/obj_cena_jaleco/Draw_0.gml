draw_set_halign(fa_center);

// Usamos um loop 'for' para percorrer o array 'caixas'
for (var i = 0; i < array_length(caixas); i++) {
    var _caixa = caixas[i]; // Aqui pegamos a caixa atual da lista
    
    // Desenha o retângulo da caixa
    draw_rectangle(_caixa.x - 80, _caixa.y - 40, _caixa.x + 80, _caixa.y + 40, true);
    
    // Desenha o nome da categoria acima da caixa
    draw_text(_caixa.x, _caixa.y - 60, _caixa.nome);
}

// Dentro do Step do obj_minigame_manager
var _total_encaixados = 0;
var _total_cartoes = instance_number(obj_cartao);

with(obj_cartao) {
    if (encaixado) _total_encaixados++;
}

if (_total_encaixados == _total_cartoes && _total_cartoes > 0) {
    show_message("Tudo organizado! Agora posso ir trabalhar.");
    
    // Manda o jogador de volta para a sala onde ele estava
    room_goto(rm_principal); // Troque pelo nome da sua sala principal
}