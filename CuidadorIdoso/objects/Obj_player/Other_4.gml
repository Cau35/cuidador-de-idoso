if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.porta_destino_pendente != "") {
    var alvo_id = obj_quest_gerenciador.porta_destino_pendente;

    with (obj_porta) {
        if (porta_id == alvo_id) {
            other.x = x + spawn_offset_x;
            other.y = y + spawn_offset_y;
        }
    }

    obj_quest_gerenciador.porta_destino_pendente = "";
}