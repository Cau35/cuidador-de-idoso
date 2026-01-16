#region Textos
function scr_textos(){
	// Retrato do PLAYER depende de quem foi escolhido na seleção
	// global.player: 0/1 = cuidador (masc), 2/3 = cuidadora (fem)
	var _p_neutro = (global.player <= 1) ? portrait_phn : portrait_pmn;
	var _p_falando = (global.player <= 1) ? portrait_phf : portrait_pmf;
	var voz_player = snd_voice_1;
	var voz_npc = snd_voice_2;
	
	
	switch(npc_nome)
	{
		case "Thats is my granny she get hit by a bazooka":
			ds_grid_add_text("Esse é um teste pra ver oque acontecesse, vou adicionar mais texto só pra ver se o texto ta acompanhando.", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Segundo texto", portrait_pmf, 1, "Personagem 2", voz_npc);
			ds_grid_add_text("Terceiro texto", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Quarto texto", _p_falando, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Quinto textoooooo", portrait_pmf, 1, "Personagem 2", voz_npc);
				add_op("Primeira Opção",								"Resposta 1");
				add_op("Segunda Opção, só que com mais texto",			"Resposta 2");
				add_op("Terceira Opção, só que com mais texto ainda",	"Resposta 3");
		break;
				case "Resposta 1":
				ds_grid_add_text("Essa é a primeira resposta.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Textooooooooooo", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 2":
				ds_grid_add_text("Essa é a segunda resposta.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Textooooooooooo", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 3":
				ds_grid_add_text("Essa é a terceira resposta.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Textooooooooooo", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
	}
}
#endregion
#region ds_grid_add_row
function ds_grid_add_row(){
	///@arg ds_grid
	
	var _grid = argument[0];
	ds_grid_resize(_grid, ds_grid_width(_grid), ds_grid_height(_grid)+ 1);
	return(ds_grid_height(_grid)-1);
}
#endregion
#region ds_grid_add_text
function ds_grid_add_text(){
	///@arg texto
	///@arg retrato
	///@arg lado
	
	var _grid = texto_grid;
	var _y = ds_grid_add_row(_grid);
	
	_grid[# 0, _y] = argument[0];
	_grid[# 1, _y] = argument[1];
	_grid[# 2, _y] = argument[2];
	_grid[# 3, _y] = argument[3];
	_grid[# 4, _y] = argument[4];
}
#endregion

function add_op(_texto, _resposta){
	op[op_num] = _texto;
	op_resposta[op_num] = _resposta;
	
	op_num++;
}