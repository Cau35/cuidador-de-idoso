if dialogo_ativo {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

   
    draw_set_alpha(0.35);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    var fala = falas[linha_atual];
    var eh_aluna = (fala.falante == "aluna");

   
    var retrato_sprite = eh_aluna ? portrait_pmf : noone;
    var retrato_w = 320;
    var retrato_h = 420;
    var retrato_x = eh_aluna ? 40 : gw - 40 - retrato_w;
    var retrato_y = gh - retrato_h - 180;

    draw_set_alpha(digitacao_completa || char_index > 0 ? 1 : 1); 
    draw_sprite_stretched(spr_eliza_dialogo, 0, retrato_x, retrato_y, retrato_w, retrato_h);
    draw_set_alpha(1);

    
    var caixa_x = 40;
    var caixa_y = gh - 170;
    var caixa_w = gw - 80;
    var caixa_h = 150;

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.95);
    draw_rectangle(caixa_x, caixa_y, caixa_x + caixa_w, caixa_y + caixa_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(caixa_x, caixa_y, caixa_x + caixa_w, caixa_y + caixa_h, true);

    
    var nome_falante = eh_aluna ? "Você" : "Professora Coordenadora";
    var cor_nome = eh_aluna ? make_color_rgb(120, 200, 255) : make_color_rgb(255, 200, 120);

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_rectangle(caixa_x + 20, caixa_y - 18, caixa_x + 20 + string_width(nome_falante)*1.4 + 24, caixa_y + 2, false);
    draw_set_color(cor_nome);
    draw_set_font(fnt_subtitulo);
    draw_set_halign(fa_left);
    draw_text(caixa_x + 32, caixa_y - 14, nome_falante);

   
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_text_ext(caixa_x + 24, caixa_y + 20, texto_atual, 26, caixa_w - 48);


    if digitacao_completa {
        draw_set_color(make_color_rgb(180, 200, 230));
        draw_set_halign(fa_right);
        var piscar = (entrega_timer mod 60 < 30) || !mostrar_entrega_jaleco;
        if piscar {
            draw_text(caixa_x + caixa_w - 20, caixa_y + caixa_h - 28,
                (linha_atual == num_falas - 1) ? "[Clique para receber o jaleco]" : "[Clique para continuar ▼]");
        }
        draw_set_halign(fa_left);
    }


    if mostrar_entrega_jaleco {
        var jx = gw/2;
        var jy = caixa_y - 90 - min(entrega_timer * 2, 40);
        var escala = 1 + min(entrega_timer / 30, 0.3);

        draw_set_alpha(min(entrega_timer / 20, 1));
        draw_sprite_ext(spr_jaleco, 0, jx, jy, escala, escala, 0, c_white, 1);
        draw_set_alpha(1);

        draw_set_color(c_white);
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_center);
        draw_text(jx, jy + 60, "Jaleco recebido!");
        draw_set_halign(fa_left);
    }

    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}