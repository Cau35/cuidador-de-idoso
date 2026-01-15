estado();

move_and_collide(velh, velv, all);

if (distance_to_object(obj_par_npcs) <= 10) {
    if (keyboard_check_pressed(ord("E"))) {

        var _npc = instance_nearest(x, y, obj_par_npcs);


        var _inst = instance_create_layer(x, y, "Instances", obj_dialogo);
        _inst.npc_nome = _npc.nome;
    }
}