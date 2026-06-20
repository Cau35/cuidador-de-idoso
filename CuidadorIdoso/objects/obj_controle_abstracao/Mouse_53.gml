if (estado_jogo != 1) {
    // 1. Verificar clique nas caixas de perguntas (Área expandida para a linha toda)
    with (obj_caixa_selecao) {
        // Checa se o clique ocorreu desde o início do quadrado até o fim da frase (750 pixels de largura)
        if (point_in_rectangle(mouse_x, mouse_y, x - 5, y - 5, x + 750, y + 25)) {
            marcado = !marcado; // Alterna entre selecionado e não selecionado
        }
    }
    
    // 2. Verificar clique no botão "Confirmar Prontuário"
    var btn_x1 = room_width - 250;
    var btn_y1 = room_height - 80;
    var btn_x2 = room_width - 50;
    var btn_y2 = room_height - 30;
    
    if (point_in_rectangle(mouse_x, mouse_y, btn_x1, btn_y1, btn_x2, btn_y2)) {
        
        var total_marcados = 0;
        var acertou_tudo = true;
        
        with (obj_caixa_selecao) {
            if (marcado) {
                total_marcados += 1;
                if (!e_clinico) acertou_tudo = false; 
            }
            if (e_clinico && !marcado) acertou_tudo = false;
        }
        
        if (total_marcados == 2 && acertou_tudo) {
            estado_jogo = 1; // Vitória
        } else if (total_marcados != 2) {
            estado_jogo = 2;
            mensagem_feedback = "Atenção: Você deve selecionar exatamente as 2 informações vitais.";
        } else {
            estado_jogo = 2;
            mensagem_feedback = "Você incluiu ruídos logísticos ou sociais. Foque apenas no monitoramento clínico imediato!";
        }
    }
}