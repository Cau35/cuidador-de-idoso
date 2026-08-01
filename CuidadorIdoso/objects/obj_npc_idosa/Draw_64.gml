// Verifica se a variável existe E se o diálogo está ativo
if (variable_instance_exists(id, "dialogo_ativo") && dialogo_ativo) {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var caixa_x = 40; 
    var caixa_y = gh - 160;
    var caixa_w = gw - 80; 
    var caixa_h = 140;

    // Fundo principal
    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.95);
    draw_rectangle(caixa_x, caixa_y, caixa_x + caixa_w, caixa_y + caixa_h, false);
    
    // Borda
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(caixa_x, caixa_y, caixa_x + caixa_w, caixa_y + caixa_h, true);

    // Barra de título do nome
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(caixa_x, caixa_y, caixa_x + caixa_w, caixa_y + 36, false);
    
    // Texto: Nome do NPC
    draw_set_color(c_white);
    draw_set_font(fnt_subtitulo); // Certifique-se de que essa fonte existe
    draw_set_halign(fa_left);
    
    var nome = variable_instance_exists(id, "nome_npc") ? nome_npc : "NPC";
    draw_text(caixa_x + 20, caixa_y + 8, nome + ":");

    // Texto: Diálogo
    draw_set_color(c_white);
    draw_set_font(fnt_normal); // Certifique-se de que essa fonte existe
    
    var texto = variable_instance_exists(id, "texto_atual") ? texto_atual : "";
    draw_text_ext(caixa_x + 20, caixa_y + 44, texto, 24, caixa_w - 40);

    // Texto: Botão de continuar
    if (variable_instance_exists(id, "digitacao_completa") && digitacao_completa) {
        draw_set_color(make_color_rgb(150, 180, 220));
        draw_set_halign(fa_right);
        
        var linha = variable_instance_exists(id, "linha_atual") ? linha_atual : 0;
        var max_falas = variable_instance_exists(id, "num_falas") ? num_falas : 1;
        
        draw_text(caixa_x + caixa_w - 16, caixa_y + caixa_h - 24,
            linha < (max_falas - 1) ? "[E] Continuar" : "[E] Iniciar Desafio");
            
        draw_set_halign(fa_left); // Reseta o alinhamento
    }
}