if !obj_gerenciador.quest_concluida {
    arrastando = true;
    offset_x = mouse_x - x;
    offset_y = mouse_y - y;
    depth = -100; // Fica na frente durante o arraste
}