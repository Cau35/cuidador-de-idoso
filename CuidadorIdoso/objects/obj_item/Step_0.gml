if (arrastando) {
    x = mouse_x + x_offset;
    y = mouse_y + y_offset;
    
    if (mouse_check_button_released(mb_left)) {
        arrastando = false;
        depth = 0;
        
        // Tenta encontrar uma caixa na posição onde o item foi solto
        var caixa_alvo = instance_place(x, y, obj_caixa);
        
        if (caixa_alvo != noone) { // Se soltou em cima de alguma caixa...
            
            // Verifica se é a caixa correta para este item
            if (caixa_alvo.tipo_caixa == caixa_correta) {
                // SUCESSO: Encaixa na caixa
                x = caixa_alvo.x + random_range(-30, 30);
                y = caixa_alvo.y + random_range(-30, 30);
                encaixado = true;
                caixa_atual = caixa_alvo.tipo_caixa;
                
                // Toca um som de acerto se tiver
                // audio_play_sound(snd_acerto, 1, false);
                
                // Checa se o puzzle todo acabou
                obj_game_manager.verificar_vitoria();
            } else {
                // ERRO: Soltou na caixa errada
                x = x_inicial;
                y = y_inicial;
                encaixado = false;
                // Opcional: Efeito visual ou sonoro de erro
            }
        } else {
            // Soltou no vazio: volta para o lugar
            x = x_inicial;
            y = y_inicial;
        }
    }
}