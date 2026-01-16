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
/// @description Desenhar Diálogo Corrigido

// Só executa se o sistema foi iniciado e a grid existe
if (inicializar == true && variable_instance_exists(id, "texto_grid")) 
{
    var _gui_l = display_get_gui_width();
    var _gui_a = display_get_gui_height();
    var _xx = 0;
    var _yy = _gui_a - 200;
    var _c = c_black;

    // Proteção da Fonte
    if (asset_get_index("fnt_dialogo") != -1) {
        draw_set_font(fnt_dialogo);
    }

    // Pega as informações da Grid
    var _txt_completo = texto_grid[# Infos.Texto, pagina];
    var _nome = texto_grid[# Infos.Nome, pagina];
    var _sprite = texto_grid[# Infos.Retrato, pagina];
    var _lado = texto_grid[# Infos.Lado, pagina];

    // Máquina de escrever
    var _texto_curto = string_copy(_txt_completo, 1, caractere);

    if (_lado == 0) {
        // Desenho Lado Esquerdo
        draw_rectangle_color(_xx + 200, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);
        draw_text(_xx + 216, _yy - 32, _nome);
        draw_text_ext(_xx + 232, _yy + 32, _texto_curto, 32, _gui_l - 264);
        if (sprite_exists(_sprite)) draw_sprite_ext(_sprite, 0, 100, _gui_a, 3, 3, 0, c_white, 1);
    } 
    else {
        // Desenho Lado Direito
        draw_rectangle_color(_xx, _yy, _gui_l - 200, _gui_a, _c, _c, _c, _c, false);
        var _stgw = string_width(_nome);
        draw_text(_gui_l - 216 - _stgw, _yy - 32, _nome);
        draw_text_ext(_xx + 32, _yy + 32, _texto_curto, 32, _gui_l - 264);
        if (sprite_exists(_sprite)) draw_sprite_ext(_sprite, 0, _gui_l - 100, _gui_a, -3, 3, 0, c_white, 1);
    }
} // <--- FECHA O IF INICIALIZAR (Resolve o erro da imagem image_dc0fe8.png)