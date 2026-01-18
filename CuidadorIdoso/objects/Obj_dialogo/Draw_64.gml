if (inicializar == true) {
    var _gui_l = display_get_gui_width();
    var _gui_a = display_get_gui_height();

    var _xx = 0;
    var _yy = _gui_a - 200;
    var _c = c_black;

    var _texto = string_copy(texto_grid[# Infos.Texto, pagina], 0, caractere);
    draw_set_font(fnt_dialogo);

    // Tipo (se por algum motivo vier undefined, assume dialogo)
    var _tipo = texto_grid[# Infos.Tipo, pagina];
    if (is_undefined(_tipo)) _tipo = "dialogo";

    // =======================
    // NARRACAO
    // =======================
    if (_tipo == "narracao") {
        // caixa ocupa tudo embaixo
        draw_rectangle_color(_xx, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);

        // texto com margens (32 px)
        draw_text_ext(_xx + 32, _yy + 32, _texto, 32, _gui_l - 64);
    }
    // =======================
    // DIALOGO NORMAL (seu código original)
    // =======================
    else {
        var _sprite = texto_grid[# Infos.Retrato, pagina];

        // Lado Esquerdo
        if (texto_grid[# Infos.Lado, pagina] == 0) {
            draw_rectangle_color(_xx + 200, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);
            draw_text(_xx + 216, _yy - 32, texto_grid[# Infos.Nome, pagina]);
            draw_text_ext(_xx + 232, _yy + 32, _texto, 32, _gui_l - 264);
            draw_sprite_ext(_sprite, 0, 100, _gui_a, 3, 3, 0, c_white, 1);
        }
        // Lado Direito
        else {
            draw_rectangle_color(_xx, _yy, _gui_l - 200, _gui_a, _c, _c, _c, _c, false);
            var _stgw = string_width(texto_grid[# Infos.Nome, pagina]);
            draw_text(_gui_l - 216 - _stgw, _yy - 32, texto_grid[# Infos.Nome, pagina]);
            draw_text_ext(_xx + 32, _yy + 32, _texto, 32, _gui_l - 264);
            draw_sprite_ext(_sprite, 0, _gui_l - 100, _gui_a, -3, 3, 0, c_white, 1);
        }
    }
}

// =======================
// OPÇÕES (seu código)
// =======================
if (op_draw == true) {
    var _gui_l = display_get_gui_width();
    var _gui_a = display_get_gui_height();
    var _xx = 0;
    var _yy = _gui_a - 200;

    var _opx = _xx + 32;
    var _opy = _yy - 48;
    var _opsep = 48;
    var _opborda = 6;

    op_selecionada += keyboard_check_pressed(ord("W")) - keyboard_check_pressed(ord("S"));
    op_selecionada = clamp(op_selecionada, 0, op_num - 1);

    for (var i = 0; i < op_num; i++) {
        var _stringw = string_width(op[i]);
        draw_sprite_ext(spr_op_background, 0, _opx, _opy - (_opsep * i), (_stringw + _opborda * 2) / 16, 1, 0, c_white, 1);
        draw_text(_opx + _opborda, _opy - (_opsep * i), op[i]);

        if (op_selecionada == i) {
            draw_sprite(spr_op_seletor, 0, _xx + 8, _opy - (_opsep * i) + 8);
        }
    }

    if (global.tecla) {
        var _inst = instance_create_layer(x, y, "Instances", obj_dialogo);
        _inst.npc_nome = op_resposta[op_selecionada];
        instance_destroy();
    }
}