if inicializar == true{
	var _gui_l = display_get_gui_width();
	var _gui_a = display_get_gui_height();

	var _xx = 0;
	var _yy = _gui_a - 200;
	var _c = c_black;
	var _sprite = texto_grid[# Infos.Retrato, pagina];
	draw_set_font(fnt_dialogo);

	//Lado Esquerdo
	if texto_grid[# Infos.Lado, pagina] == 0{
		draw_rectangle_color(_xx + 200, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);
		draw_text(_xx + 216, _yy - 32, texto_grid[# Infos.Nome, pagina]);
		draw_text_ext(_xx + 232, _yy + 32, texto_grid[# Infos.Texto, pagina], 32, _gui_l - 264);
	
		draw_sprite_ext(_sprite, 0, 100, _gui_a, 3, 3, 0, c_white, 1);
	}//Lado Direito
	else{
		draw_rectangle_color(_xx, _yy, _gui_l - 200, _gui_a, _c, _c, _c, _c, false);
		var _stgw = string_width(texto_grid[# Infos.Nome, pagina]);
		draw_text(_gui_l - 216 - _stgw, _yy - 32, texto_grid[# Infos.Nome, pagina]);
		draw_text_ext(_xx + 32, _yy + 32, texto_grid[# Infos.Texto, pagina], 32, _gui_l - 264);
		draw_sprite_ext(_sprite, 0, _gui_l - 100, _gui_a, -3, 3, 0, c_white, 1);
	}
}