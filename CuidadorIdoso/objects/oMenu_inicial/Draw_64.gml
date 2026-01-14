var tam_menu = array_length(menu_inicial);
for(var i = 0; i < tam_menu; i++)
{
	var _wgui = display_get_gui_width();
	var _hgui = display_get_gui_height();
	
	
	draw_text_transformed(_wgui / 2, _hgui / 2, menu_inicial[i], 1, 1, 0);
}