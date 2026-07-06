if fixado exit;
if gerenciador.fase != 0 exit;

if point_in_rectangle(mouse_x, mouse_y, x, y, x+largura, y+altura) {
    arrastando = true;
    offset_x = mouse_x - x;
    offset_y = mouse_y - y;
    depth = -200;

    var ger = gerenciador;
    if no_slot >= 0 {
        ger.slot_conteudo[no_slot] = -1;
        ger.slot_correto[no_slot]  = false;
        ger.slot_errado[no_slot]   = false;
        no_slot = -1;
    }
}