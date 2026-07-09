if dialogo_ativo {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    // Caixa de diálogo
    var bw = gw-80; var bh = 160;
    var bx = 40;    var by = gh-bh-20;

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(bx, by, bx+bw, by+bh, false);
    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(bx, by, bx+bw, by+bh, true);
    draw_rectangle(bx, by, bx+bw, by+38, false);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_left);
    draw_text(bx+20, by+8, "Professor de Decomposicao:");

    draw_set_color(make_color_rgb(20,30,60));
    draw_set_font(fnt_normal);
    draw_text_ext(bx+20, by+48, texto_atual, 26, bw-40);

    // Dica
    if digitacao_completa {
        draw_set_color(make_color_rgb(100,130,180));
        draw_set_halign(fa_right);
        draw_text(bx+bw-16, by+bh-28,
            linha_atual < num_falas-1 ? "[E] Continuar" : "[E] Iniciar Desafio");
    }
    draw_set_halign(fa_left);
}