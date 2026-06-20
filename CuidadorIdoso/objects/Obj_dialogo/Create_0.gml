enum Infos{
	Texto,
	Retrato,
	Lado,
	Nome,
	Voz,
	Tipo
}


npc_nome = "";
texto_grid = ds_grid_create(6, 0);
pagina = 0;

op[0] = "";
op_resposta[0] = "";
op_num = 0;
op_selecionada = 0;
op_draw = false;

inicializar = false;

caractere = 0;
alarm[0] = 1;
voice_id = -1;
voice_asset = noone;

cutscene_bg_page = [];
global.mudar_de_sala = false;