// PARTE 1 — definição da função (pode ficar aqui ou no Create)
function desenhar_fala_professor() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var bw = gw - 80;
    var bh = 240;
    var bx = 40;
    var by = gh - bh - 20;

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(bx, by, bx + bw, by + bh, false);
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(bx, by, bx + bw, by + bh, true);
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(bx, by, bx + bw, by + 38, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_left);
    draw_text(bx + 20, by + 8, "Professor:");
    draw_set_color(make_color_rgb(20, 30, 60));
    draw_set_font(fnt_normal);
    var fala = "Percebeu? Preparar uma visita domiciliar parecia uma tarefa grande.\nMas, quando você separou em partes menores — o que vestir,\no que levar e o que conferir — ficou muito mais fácil!\n\nIsso é DECOMPOSIÇÃO.";
    draw_text_ext(bx + 20, by + 48, fala, 26, bw - 40);
    var btn_w = 140; var btn_h = 36;
    var btn_x = bx + bw - btn_w - 16;
    var btn_y = by + bh - btn_h - 12;
    var hover = point_in_rectangle(
        display_mouse_get_x(), display_mouse_get_y(),
        btn_x, btn_y, btn_x + btn_w, btn_y + btn_h);
    draw_set_color(hover ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(btn_x + btn_w/2, btn_y + 8, "Continuar [E]");
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}

// =========================================
// PARTE 2 — código que roda a cada frame (PRECISA ESTAR AQUI, fora da função)
// =========================================
draw_set_alpha(0.85);
draw_set_color(c_navy);
draw_rectangle(0, 0, display_get_gui_width(), 60, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);
draw_text(display_get_gui_width() / 2, 15, "Preparando a Visita Domiciliar");

if mostrar_feedback {
    draw_set_color(feedback_cor);
    draw_set_font(fnt_normal);
    draw_text(display_get_gui_width()/ 2,display_get_gui_height() - 80, feedback_texto);
}

// ← ESTA LINHA É O QUE ESTAVA FALTANDO
if mostrar_fala_professor {
    desenhar_fala_professor(); // chama a função acima
}

draw_set_halign(fa_left);
draw_set_font(-1);
