if dialogo_ativo {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var caixa_x = 40; var caixa_y = gh - 160;
    var caixa_w = gw - 80; var caixa_h = 140;

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.95);
    draw_rectangle(caixa_x, caixa_y, caixa_x+caixa_w, caixa_y+caixa_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(caixa_x, caixa_y, caixa_x+caixa_w, caixa_y+caixa_h, true);

    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(caixa_x, caixa_y, caixa_x+caixa_w, caixa_y+36, false);
    draw_set_color(c_white);
    draw_set_font(fnt_subtitulo);
    draw_set_halign(fa_left);
    draw_text(caixa_x+20, caixa_y+8, nome_npc + ":");

    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_text_ext(caixa_x+20, caixa_y+44, texto_atual, 24, caixa_w-40);

    if digitacao_completa {
        draw_set_color(make_color_rgb(150, 180, 220));
        draw_set_halign(fa_right);
        draw_text(caixa_x+caixa_w-16, caixa_y+caixa_h-24,
            linha_atual < num_falas-1 ? "[E] Continuar" : "[E] Iniciar Desafio");
        draw_set_halign(fa_left);
    }
}