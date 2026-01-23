if instance_exists(obj_dialogo){
	global.dialogo = true;
}

global.tecla = keyboard_check_pressed(ord("E"));

// cooldown do idoso
if (!variable_global_exists("puzzle_pronto")) global.puzzle_pronto = true;
if (!variable_global_exists("puzzle_cd")) global.puzzle_cd = 0;
if (!variable_global_exists("puzzle")) global.puzzle = 0;

if (!global.puzzle_pronto) {
    global.puzzle_cd--;
    if (global.puzzle_cd <= 0) {
        global.puzzle_pronto = true;
        global.puzzle_cd = 0;
    }
}