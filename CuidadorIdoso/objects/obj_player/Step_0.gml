//movi

var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var vel = 4;

if (move_x != 0 || move_y != 0)
{
    var len = point_distance(0, 0, move_x, move_y);

    move_x /= len;
    move_y /= len;

    x += move_x * vel;
    y += move_y * vel;
}







if (global.dialogo)
{
    velh = 0;
    velv = 0;
	sprite_index = player.sprite_idle;
    exit;
}

if instance_exists(obj_pause)
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