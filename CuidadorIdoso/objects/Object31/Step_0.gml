if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    segurando = true;
    offset_x = x - mouse_x;
    offset_y = y - mouse_y;
}

if (segurando) {
    x = mouse_x + offset_x;
    y = mouse_y + offset_y;
    
    if (mouse_check_button_released(mb_left)) {
        segurando = false;
        
        // Verificar se soltou em cima de uma caixa
        var _manager = Object30;
        for (var i = 0; i < array_length(_manager.caixas); i++) {
            var _c = _manager.caixas[i];
            if (point_distance(x, y, _c.x, _c.y) < 80) {
                if (grupo_correto == _c.ID) {
                    x = _c.x;
                    y = _c.y;
                    encaixado = true;
                    // Lógica opcional: travar o cartão ou dar feedback visual
                } else {
                    // Errou: Volta para uma posição aleatória
                    x = random_range(100, 400);
                    y = random_range(100, 300);
                }
            }
        }
    }
}