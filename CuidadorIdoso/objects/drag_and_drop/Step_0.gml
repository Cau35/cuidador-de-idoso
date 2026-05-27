// --- Documentação: Botão de Voltar ---
// room_previous(room): Verifica qual é a sala anterior à atual.
// room_goto_previous(): Move o jogador para a sala anterior.

var rato_em_cima = position_meeting(mouse_x, mouse_y, id);
var clique_esquerdo = mouse_check_button_pressed(mb_left);

if (rato_em_cima && clique_esquerdo) {
    // Verificamos se existe uma sala anterior para evitar erros
    if (room_exists(room_previous(room))) {
        room_goto(Room3);
    } else {
        show_debug_message("Não existe uma sala anterior!");
    }
}
