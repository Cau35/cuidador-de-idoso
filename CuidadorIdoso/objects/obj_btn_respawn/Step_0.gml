// --- Verificação de Clique na GUI ---

// Obtém a posição do rato em relação à interface (GUI)
var rato_x_gui = device_mouse_x_to_gui(0);
var rato_y_gui = device_mouse_y_to_gui(0);

// Verifica se o rato está dentro do retângulo do botão
var em_cima = (rato_x_gui > x_gui - largura/2 && rato_x_gui < x_gui + largura/2 &&
               rato_y_gui > y_gui - altura/2 && rato_y_gui < y_gui + altura/2);

if (em_cima && mouse_check_button_pressed(mb_left)) {
    // Ação de Respawn: vai para a sala do jogo
    room_goto(Room_minigame1); 
}