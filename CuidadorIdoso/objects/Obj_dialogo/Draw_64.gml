// =======================
// DRAW GUI - obj_dialogo
// (com texto colorido + narração + diálogo + opções)
// =======================

if (inicializar == true) {
    var _gui_l = display_get_gui_width();
    var _gui_a = display_get_gui_height();

    var _xx = 0;
    var _yy = _gui_a - 200;
    var _c  = c_black;

    draw_set_font(fnt_dialogo);
    draw_set_color(c_white);

    // texto parcial (efeito máquina de escrever)
    var _texto = string_copy(texto_grid[# Infos.Texto, pagina], 0, caractere);

    // Tipo (fallback)
    var _tipo = texto_grid[# Infos.Tipo, pagina];
    if (is_undefined(_tipo)) _tipo = "dialogo";

    // ==========================================
    // ✅ ADIÇÃO: cutscene muda imagem por página
    // ==========================================
    if (variable_global_exists("cutscene_ativa") && global.cutscene_ativa) {
        if (array_length(cutscene_bg_page) > 0) {
            global.cutscene_bg = cutscene_bg_page[pagina];
        }
    }
    // ==========================================

    // =======================
    // NARRAÇÃO
    // =======================
    if (_tipo == "narracao") {

        // caixa ocupa tudo embaixo
        draw_rectangle_color(_xx, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);

        // texto com margens
        draw_text_color_ext(_xx + 32, _yy + 32, _texto, 32, _gui_l - 64);
    }
    // =======================
    // DIÁLOGO NORMAL
    // =======================
    else {

        var _sprite = texto_grid[# Infos.Retrato, pagina];

        // Lado Esquerdo
        if (texto_grid[# Infos.Lado, pagina] == 0) {

            draw_rectangle_color(_xx + 200, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);

            // Nome
            draw_text(_xx + 216, _yy - 32, texto_grid[# Infos.Nome, pagina]);

            // Texto (colorido)
            draw_text_color_ext(_xx + 232, _yy + 32, _texto, 32, _gui_l - 264);

            // Retrato
            if (!is_undefined(_sprite) && _sprite != noone) {
                draw_sprite_ext(_sprite, 0, 100, _gui_a, 3, 3, 0, c_white, 1);
            }
        }
        // Lado Direito
        else {

            draw_rectangle_color(_xx, _yy, _gui_l - 200, _gui_a, _c, _c, _c, _c, false);

            // Nome alinhado à direita
            var _nome = texto_grid[# Infos.Nome, pagina];
            var _stgw = string_width(_nome);
            draw_text(_gui_l - 216 - _stgw, _yy - 32, _nome);

            // Texto (colorido)
            draw_text_color_ext(_xx + 32, _yy + 32, _texto, 32, _gui_l - 264);

            // Retrato espelhado
            if (!is_undefined(_sprite) && _sprite != noone) {
                draw_sprite_ext(_sprite, 0, _gui_l - 100, _gui_a, -3, 3, 0, c_white, 1);
            }
        }
    }
}

// =======================
// OPÇÕES (seu sistema)
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

    draw_set_font(fnt_dialogo);
    draw_set_color(c_white);

    op_selecionada += keyboard_check_pressed(ord("W")) - keyboard_check_pressed(ord("S"));
    op_selecionada = clamp(op_selecionada, 0, op_num - 1);

    for (var i = 0; i < op_num; i++) {
        var _stringw = string_width(op[i]);

        draw_sprite_ext(
            spr_op_background, 0,
            _opx, _opy - (_opsep * i),
            (_stringw + _opborda * 2) / 16,
            1, 0, c_white, 1
        );

        draw_text_color_ext(_opx + _opborda, _opy - (_opsep * i), op[i], 32, _gui_l - 64);

        if (op_selecionada == i) {
            draw_sprite(spr_op_seletor, 0, _xx + 8, _opy - (_opsep * i) + 8);
        }
    }

    // escolher opção
    if (global.tecla) {
        var _inst = instance_create_layer(x, y, "Instances", obj_dialogo);
        _inst.npc_nome = op_resposta[op_selecionada];
        instance_destroy();
    }
}