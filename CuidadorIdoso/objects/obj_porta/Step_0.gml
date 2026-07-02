if (instance_exists(Obj_player)) {
    var dist = point_distance(x, y, Obj_player.x, Obj_player.y);

    if (dist <= raio_interacao) {
        obj_quest_gerenciador.set_npc_proximo(nome_acao);

        if (keyboard_check_pressed(ord("E"))) {
            usar_porta();
        }
    }
}


function usar_porta() {
    // Grava qual porta de destino o jogador deve usar como ponto de chegada
    obj_quest_gerenciador.porta_destino_pendente = porta_destino_id;
    room_goto(room_destino);
}