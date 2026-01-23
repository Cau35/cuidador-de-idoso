if instance_exists(obj_dialogo){
	global.dialogo = true;
}

global.tecla = keyboard_check_pressed(ord("E"));

if (global.puzzle_cd > 0) {
    global.puzzle_cd--;
}