// Pega a posição do mouse relativa à tela (GUI)
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);

// Verifica se o mouse está dentro do "retângulo" do botão
if (point_in_rectangle(mouse_x_gui, mouse_y_gui, x_gui, y_gui, x_gui + largura, y_gui + altura)) {
    
    // Se estiver em cima, verifica se o botão esquerdo foi clicado
    if (mouse_check_button_pressed(mb_left)) {
        // Troca de room!
        room_goto(rm_banheiro_idoso);
    }
}