var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);



draw_set_font(fmenu_inicial);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var tam_menu = array_length(menu_inicial);
for(var i = 0; i < tam_menu; i++)
{
	var _wgui = display_get_gui_width();
	var _hgui = display_get_gui_height();
	
	var _hstr = string_height("I");
	var _wstr = string_width(menu_inicial[i]);
	
	var x1 = _wgui / 2 - _wstr / 2;
	var y1 = _hgui / 2 - _hstr / 2 + _hstr * i //top left
	
	var x2 = _wgui / 2 + _wstr / 2;
	var y2 = _hgui / 2 + _hstr / 2 + _hstr * i //buttom right
	
	if(point_in_rectangle(_mx, _my, x1, y1, x2, y2))
	{
		esc[i] = lerp(esc[i], 1.4, 0.15);
		
		if(mouse_check_button_pressed(mb_left))
		{
			switch menu_inicial[i]
			{
				case menu_inicial[0]: // Jogar
    // Deleta o save anterior
    if file_exists("save01.ini") {
        file_delete("save01.ini");
    }

    // Reseta ou cria o gerenciador do zero
    if instance_exists(obj_quest_gerenciador) {
        // Reseta todas as variáveis
        with (obj_quest_gerenciador) {
            quest_completa[0] = false;
            quest_completa[1] = false;
            quest_completa[2] = false;
            quest_completa[3] = false;
            integradora_completa  = false;
            tablet_recebido       = false;
            jaleco_vestido        = false;
            saldo_moedas          = 0;
            inventario            = [];
            objetivos             = ["Visitar os 4 professores na sala de informática"];
            mensagens             = [{
                remetente: "Professora Coordenadora",
                texto: "Bem-vinda à formação! Visite os 4 professores na sala de informática."
            }];
            porta_destino_pendente = "";
            load_x = 0;
            load_y = 0;
            save_slot_existe      = false;
            pausado               = false;
            tablet_aberto         = false;
            tablet_aba            = 0;
        }
    } else {
        // Se não existir ainda, cria do zero
        instance_create_layer(0, 0, "Instances", obj_quest_gerenciador);
    }

    room_goto(rm_inicio);
    break;
					 case menu_inicial[1]: // Continuar
            if file_exists("save01.ini") {
              
                if !instance_exists(obj_quest_gerenciador) {
                    instance_create_layer(0, 0, "Instances", obj_quest_gerenciador);
                }
                obj_quest_gerenciador.carregar_jogo();
            }
            break;
				case menu_inicial[2]: // Opções
					room_goto(opcoes)
					break;
				case menu_inicial[3]: // Sair
					game_end()
					break;
			}
		}
	}
	else
	{
		esc[i] = lerp(esc[i], 1, 0.15);
		// Cor normal ou acinzentada dependendo se tem save
if menu_inicial[i] == "Continuar" && !file_exists("save01.ini") {
    draw_set_alpha(0.4); // acinzenta se não tem save
} else {
    draw_set_alpha(1);
}

draw_text_transformed(_wgui / 2, _hgui / 2 + _hstr * i, menu_inicial[i], esc[i], esc[i], 0);
draw_set_alpha(1); // reseta depois de desenhar
	}
	
	draw_text_transformed(_wgui / 2, _hgui / 2 + _hstr * i, menu_inicial[i], esc[i], esc[i], 0);
}

draw_set_halign(-1);
draw_set_valign(-1);
draw_set_font(-1);