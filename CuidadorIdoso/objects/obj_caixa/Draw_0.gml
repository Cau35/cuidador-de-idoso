// Fundo da caixa
draw_set_alpha(0.3);
draw_set_color(c_teal);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_alpha(1);

// Borda
draw_set_color(c_navy);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

// Título da caixa
draw_set_color(c_navy);
draw_set_font(fnt_dialogo);
draw_set_halign(fa_center);
draw_text((bbox_left + bbox_right) / 2, bbox_top + 10,
    obj_gerenciador.caixa_nomes[indice]);

draw_set_halign(fa_left);
draw_set_font(-1);
draw_set_alpha(1);