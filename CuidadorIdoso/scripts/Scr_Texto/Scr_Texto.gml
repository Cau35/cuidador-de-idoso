function scr_textos(){
	
	switch(npc_nome)
	{
		case "Thats is my granny she get hit by a bazooka":
			ds_grid_add_text("Primeiro texto", portrait_phn, 0, "Personagem 1");
			ds_grid_add_text("Segundo texto", portrait_pmf, 1, "Personagem 2");
			ds_grid_add_text("Terceiro texto", portrait_phn, 0, "Personagem 1");
			ds_grid_add_text("Quarto texto", portrait_phf, 0, "Personagem 1");
		break;
	}
}

function ds_drid_add_row(){
	///@arg ds_grid
	
	var _grid = argument[0];
	ds_grid_resize(_grid, ds_grid_width(_grid), ds_grid_height(_grid)+ 1);
	return(ds_grid_height(_grid)-1);
}

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
}