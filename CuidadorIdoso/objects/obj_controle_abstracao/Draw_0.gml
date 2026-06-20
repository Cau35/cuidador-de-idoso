// Forçar alinhamentos padrão no início do desenho
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 1. DESENHAR CAIXA DO DIÁLOGO DA COLEGA
draw_set_color(c_white);
draw_rectangle(40, 20, room_width - 40, 240, false);

// Texto do relato
draw_set_color(c_black);
draw_text_ext(60, 40, "Colega diz: " + relato_colega, 22, room_width - 120);

// 2. DESENHAR A INSTRUÇÃO DO DESAFIO
draw_set_color(c_yellow);
draw_text_ext(40, 260, pergunta, 22, room_width - 80);

// 3. DESENHAR AS LINHAS SELECIONÁVEIS
if (estado_jogo != 1) {
    
    var sprite_alvo = spr_checkbox; 
    
    with (obj_caixa_selecao) {
        // Verifica se o mouse está passando por cima da frase (efeito Hover)
        var mouse_na_linha = point_in_rectangle(mouse_x, mouse_y, x, y - 5, x + 750, y + 25);
        
        // Se estiver marcado, desenha um fundo sutil verde. Se o mouse estiver em cima, destaca em cinza.
        if (marcado) {
            draw_set_color(c_green);
            draw_set_alpha(0.3);
            draw_rectangle(x - 5, y - 5, x + 750, y + 25, false);
            draw_set_alpha(1.0);
        } else if (mouse_na_linha) {
            draw_set_color(c_dkgray);
            draw_set_alpha(0.2);
            draw_rectangle(x - 5, y - 5, x + 750, y + 25, false);
            draw_set_alpha(1.0);
        }

        // DESENHO DO QUADRADINHO (CHECKBOX)
        if (sprite_exists(sprite_alvo)) {
            draw_sprite(sprite_alvo, marcado, x, y);
        } else {
            // Quadrado indicador padrão se não houver sprite
            draw_set_color(marcado ? c_green : c_black);
            draw_rectangle(x, y, x + 18, y + 18, false); 
            
            // Borda do quadrado
            draw_set_color(c_white);
            draw_rectangle(x, y, x + 18, y + 18, true);
            
            // Desenha um "X" interno se estiver marcado
            if (marcado) {
                draw_text(x + 4, y + 2, "X");
            }
        }
        
        // DESENHO DO TEXTO DA PERGUNTA/OPÇÃO
        // Se estiver marcado, o texto fica verde claro, se não, fica branco
        draw_set_color(marcado ? c_lime : c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(x + 35, y + 10, texto_opcao);
    }
    draw_set_valign(fa_top); // Reseta alinhamento vertical
    
    // 4. DESENHAR BOTÃO VIRTUAL DE CONFIRMAR
    var btn_x1 = room_width - 250;
    var btn_y1 = room_height - 80;
    var btn_x2 = room_width - 50;
    var btn_y2 = room_height - 30;
    
    var mouse_no_botao = point_in_rectangle(mouse_x, mouse_y, btn_x1, btn_y1, btn_x2, btn_y2);
    draw_set_color(mouse_no_botao ? c_green : c_dkgray); 
    draw_rectangle(btn_x1, btn_y1, btn_x2, btn_y2, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((btn_x1 + btn_x2) / 2, (btn_y1 + btn_y2) / 2, "Confirmar Prontuário");
    draw_set_valign(fa_top); 
}

// 5. FEEDBACK DE ERRO
if (estado_jogo == 2) {
    draw_set_color(c_red);
    draw_set_halign(fa_left);
    draw_text_ext(40, room_height - 40, mensagem_feedback, 20, room_width - 300);
}

// 6. TELA DE SUCESSO
if (estado_jogo == 1) {
    draw_set_color(c_black);
    draw_set_alpha(0.9);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1.0);
    
    draw_set_color(c_green);
    draw_set_halign(fa_center);
    draw_text_transformed(room_width / 2, 80, "CONCEITO COGNITIVO: ABSTRAÇÃO", 1.2, 1.2, 0);
    
    draw_set_color(c_white);
    draw_text_ext(room_width / 2, room_height / 2 - 60, texto_tutor, 28, 850);
}