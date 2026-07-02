if mostrar_fala_professor {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var bw = gw - 80; var bh = 240;
    var bx = 40;      var by = gh - bh - 20;
    var btn_w = 140;  var btn_h = 36;
    var btn_x = bx + bw - btn_w - 16;
    var btn_y = by + bh - btn_h - 12;

    if point_in_rectangle(
        display_mouse_get_x(), display_mouse_get_y(),
        btn_x, btn_y, btn_x + btn_w, btn_y + btn_h) {
        mostrar_fala_professor = false;
        obj_quest_gerenciador.marcar_quest_completa(0);
        room_goto(rm_sala_informatica);
    }
}