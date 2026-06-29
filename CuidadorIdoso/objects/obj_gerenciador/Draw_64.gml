
draw_set_alpha(0.85);
draw_set_color(c_navy);
draw_rectangle(0, 0, display_get_gui_width(), 60, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_set_font(fnt_dialogo); 
draw_set_halign(fa_center);
draw_text(display_get_gui_width() / 2, 15, "Preparando a Visita Domiciliar");


if mostrar_feedback {
    draw_set_color(c_yellow);
    draw_set_font(fnt_dialogo);
    draw_text(display_get_gui_width() / 2, display_get_gui_height() - 80, feedback_texto);
}


if mostrar_fala_professor {
    desenhar_fala_professor();
}

draw_set_halign(fa_left);
draw_set_font(-1);