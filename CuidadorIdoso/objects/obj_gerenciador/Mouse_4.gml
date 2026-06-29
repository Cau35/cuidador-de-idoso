if mostrar_fala_professor {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var bx = 60; var by = gh - 260;
    var bw = gw - 120; var bh = 220;
    // Clicou no botão "Continuar"?
    if point_in_rectangle(mouse_x, mouse_y,
        bx + bw - 110, by + bh - 45,
        bx + bw - 10,  by + bh - 10) {
        mostrar_fala_professor = false;
       room_goto_next();
    }
}