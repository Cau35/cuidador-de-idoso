draw_self();

if !obj_quest_gerenciador.quest_idoso_disponivel() {
    var cx = x;
    var cy = y - sprite_height/2 - 24;
    draw_set_color(make_color_rgb(180, 30, 30));
    draw_rectangle(cx-36, cy-14, cx+36, cy+14, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(cx, cy-6, "BLOQUEADO");
    draw_set_halign(fa_left);
} else {
    // Destaque de disponível
    var cx = x;
    var cy = y - sprite_height/2 - 24;
    draw_set_color(make_color_rgb(20, 140, 60));
    draw_rectangle(cx-44, cy-14, cx+44, cy+14, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(cx, cy-6, "DISPONIVEL!");
    draw_set_halign(fa_left);
}