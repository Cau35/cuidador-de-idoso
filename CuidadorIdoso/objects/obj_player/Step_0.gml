estado();

move_and_collide(velh, velv, all);

if (distance_to_object(obj_par_npcs) <= 10) {
    if global.tecla and global.dialogo == false{

        var _npc = instance_nearest(x, y, obj_par_npcs);


        var _inst = instance_create_layer(x, y, "Instances", obj_dialogo);
        _inst.npc_nome = _npc.nome;
    }
}