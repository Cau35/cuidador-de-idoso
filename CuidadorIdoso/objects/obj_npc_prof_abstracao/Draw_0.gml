
draw_self();


if variable_instance_exists(id, "indice_quest") {
    if !obj_quest_gerenciador.quest_disponivel(indice_quest)
    && !obj_quest_gerenciador.quest_completa[indice_quest] {
        var cx = x;
        var cy = y - sprite_height/2 - 24;

        draw_set_color(make_color_rgb(180, 30, 30));
        draw_rectangle(cx-36, cy-14, cx+36, cy+14, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(cx, cy-6, "BLOQUEADO");
        draw_set_halign(fa_left);
    }
}