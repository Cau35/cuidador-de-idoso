// --- Documentação: Botão de Navegação Direta ---
// room_goto(nome): Salta diretamente para a sala indicada.

var rato_em_cima = position_meeting(mouse_x, mouse_y, id);
var clique_esquerdo = mouse_check_button_pressed(mb_left);

if (rato_em_cima && clique_esquerdo) {
    // Substitui 'Room2' pelo nome da tua sala no Asset Browser
    if (room_exists(Room_gameover)) {
        room_goto(Room_gameover);
    }
}