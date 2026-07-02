

if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.pausado) exit;
if (instance_exists(obj_gerenciador) && obj_gerenciador.quest_concluida) exit;
if (instance_exists(obj_gerenciador) && obj_gerenciador.mostrar_fala_professor) exit;
if (instance_exists(obj_cena_jaleco)  && obj_cena_jaleco.dialogo_ativo) exit;
if instance_exists(obj_gerenciador) && obj_gerenciador.mostrar_fala_professor {
    exit;
}
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo) exit;



if (instance_exists(Obj_player)) {
    var dist = point_distance(x, y, Obj_player.x, Obj_player.y);

    if (dist <= raio_interacao) {
        obj_quest_gerenciador.set_npc_proximo(nome_npc);

        if (keyboard_check_pressed(ord("E"))) {
            iniciar_interacao();
        }
    }
}