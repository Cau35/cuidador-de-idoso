//global.escolhe_player = true;
//global.player = 0;
//global.dialogo = false;

if (!variable_global_exists("escolhe_player"))
global.escolhe_player = true;
if (!variable_global_exists("player")) global.player = 0;

global.dialogo = false;
global.pegar_jaleco = false;

if (!variable_global_exists("cutscene_bg"))
{ global.cutscene_bg = noone;
}

global.cutscene_ativa = false;

if (!variable_global_exists("puzzle")) global.puzzle = 0;
if (!variable_global_exists("puzzle_cd")) global.puzzle_cd = 0;

global.moedas = 0;