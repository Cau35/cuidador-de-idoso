if (global.dialogo)
{
    velh = 0;
    velv = 0;
	sprite_index = player.sprite_idle;
    exit;
}

 // === APLICAR JALECO EM TEMPO DE JOGO ===
if (global.pegar_jaleco)
{
	if (global.player == 0) global.player = 1;
	else if (global.player == 2) global.player = 3;

	switch (global.player)
	{
		case 1: player = new Personagem_CuidadorCJ(); break;
		case 3: player = new Personagem_CuidadoraCJ(); break;
	}

	sprite_index = player.sprite_idle;

	global.pegar_jaleco = false;
}

estado();

move_and_collide(velh, velv, all);

if (distance_to_object(obj_par_npcs) <= 10) {
    if global.tecla and global.dialogo == false{

        var _npc = instance_nearest(x, y, obj_par_npcs);


        var _inst = instance_create_layer(x, y, "Instances", obj_dialogo);
        _inst.npc_nome = _npc.nome;
    }
}