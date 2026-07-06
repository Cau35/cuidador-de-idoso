
var dialogo_rolando = (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo);


if pausado && mouse_check_button_pressed(mb_left) {
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    if pause_aba == 0 {
        var pw = 360; var ph = 380;
        var px = gw/2 - pw/2; var py = gh/2 - ph/2;
        var btn_w = pw - 60; var btn_h = 48; var btn_gap = 16;
        var btn_start_y = py + 88;

        // Botão 0 — Continuar
        if point_in_rectangle(mx, my, px+30, btn_start_y, px+30+btn_w, btn_start_y+btn_h) {
            pausado = false;
        }
        // Botão 1 — Salvar
        var by1 = btn_start_y + 1*(btn_h+btn_gap);
        if point_in_rectangle(mx, my, px+30, by1, px+30+btn_w, by1+btn_h) {
            pause_aba = 1;
        }
        // Botão 2 — Carregar
        var by2 = btn_start_y + 2*(btn_h+btn_gap);
        if point_in_rectangle(mx, my, px+30, by2, px+30+btn_w, by2+btn_h) {
            if save_slot_existe {
                carregar_jogo();
                pausado = false;
            }
        }
        // Botão 3 — Sair
        var by3 = btn_start_y + 3*(btn_h+btn_gap);
        if point_in_rectangle(mx, my, px+30, by3, px+30+btn_w, by3+btn_h) {
            pause_aba = 2;
        }
    }

    else if pause_aba == 1 {
        var pw = 400; var ph = 200;
        var px = gw/2 - pw/2; var py = gh/2 - ph/2;

        if point_in_rectangle(mx, my, px+30, py+120, px+180, py+164) {
            salvar_jogo();
            pause_aba = 0;
        }
        if point_in_rectangle(mx, my, px+pw-180, py+120, px+pw-30, py+164) {
            pause_aba = 0;
        }
    }

    else if pause_aba == 2 {
        var pw = 400; var ph = 200;
        var px = gw/2 - pw/2; var py = gh/2 - ph/2;

        if point_in_rectangle(mx, my, px+30, py+120, px+180, py+164) {
            pausado = false;
            room_goto(GameMenu);
        }
        if point_in_rectangle(mx, my, px+pw-180, py+120, px+pw-30, py+164) {
            pause_aba = 0;
        }
    }
}
if keyboard_check_pressed(vk_escape) && !dialogo_rolando {
    if quest_overlay_ativa != -1 {
        // ESC fecha o overlay de quest, não abre o pause
        fechar_quest_overlay();
    } else {
        pausado = !pausado;
        pause_aba = 0;
        if tablet_aberto { tablet_aberto = false; }
    }
}




if hud_moeda_anim > 0 {
    hud_moeda_anim--;
}

// Atualização segura da flag de NPC próximo (evita problema de ordem de execução)
hud_npc_perto = hud_npc_perto_proximo_frame;
hud_npc_nome  = hud_npc_nome_proximo_frame;
hud_npc_perto_proximo_frame = false;
hud_npc_nome_proximo_frame  = "";


if keyboard_check_pressed(ord("T")) && tablet_recebido {
    tablet_aberto = !tablet_aberto;
}






if quest_overlay_ativa == 1 {


    if p2_fase == 0 && keyboard_check_pressed(ord("E")) {
        p2_fase = 1;
    }

 if p2_fase == 1 && mouse_check_button_pressed(mb_left) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var ex = gui_w / 1280;
    var ey = gui_h / 720;

    var base_y = 320*ey;
    var alt    = 15*ey;
    var gap    = 5*ey;

    for (var i = 0; i < 4; i++) {
        var oy = base_y + i*(alt+gap);
        if point_in_rectangle(mx, my, 40*ex, oy, 1240*ex, oy+alt) {
            p2_resposta_selecionada = i;
            p2_fase = 2;
            if i == p2_resposta_correta {
                ganhar_moedas(20);
            } else {
                ganhar_moedas(5);
            }
        }
    }
}
        


    if p2_fase == 2 {
        var avancar = keyboard_check_pressed(ord("E"))
                   || mouse_check_button_pressed(mb_left);
        if avancar { p2_fase = 3; }
    }


    if p2_fase == 3 && keyboard_check_pressed(ord("E")) {
        marcar_quest_completa(1);
        fechar_quest_overlay();
    }
}

if quest_overlay_ativa == 2 {


    if p3_fase == 0 && !p3_digitacao_completa {
        p3_timer_digitar++;
        if p3_timer_digitar >= 1 {
            p3_timer_digitar = 0;
            if p3_char_index < string_length(p3_relato) {
                p3_char_index++;
                p3_texto_atual = string_copy(p3_relato, 1, p3_char_index);
            } else {
                p3_digitacao_completa = true;
            }
        }
    }

    var clicou = mouse_check_button_pressed(mb_left);
    var mx =  device_mouse_x_to_gui(0);
    var my =  device_mouse_y_to_gui(0);


    if p3_fase == 0 {
        if (keyboard_check_pressed(ord("E")) || clicou) {
            if !p3_digitacao_completa {
                // Pula digitação
                p3_texto_atual = p3_relato;
                p3_char_index  = string_length(p3_relato);
                p3_digitacao_completa = true;
            } else {

                p3_fase = 1;
            }
        }
    }


    else if p3_fase == 1 && clicou {
     
        if p3_itens_selecionados == 2
        && point_in_rectangle(mx, my, 980, 660, 1240, 704) {
            var certos = 0;
            for (var i = 0; i < 6; i++) {
                if p3_itens_sel[i] && p3_itens_corretos[i] certos++;
            }
            p3_acertou = (certos == 2);
            p3_fase = 2;
            if p3_acertou { ganhar_moedas(20); } else { ganhar_moedas(5); }

        } else {
            // Clique nos itens
            for (var i = 0; i < 6; i++) {
                var iy = 340 + i*56;
                if point_in_rectangle(mx, my, 60, iy, 1220, iy+50) {
                    if !p3_itens_sel[i] {
                        if p3_itens_selecionados < 2 {
                            p3_itens_sel[i] = true;
                            p3_itens_selecionados++;
                        }
                    } else {
                        p3_itens_sel[i] = false;
                        p3_itens_selecionados--;
                    }
                    break;
                }
            }
        }
    }

    // Fase 2 — ver análise
    else if p3_fase == 2 && clicou {
        if point_in_rectangle(mx, my, 960, 684, 1230, 716) {
            p3_fase = 3;
        }
    }

    
    else if p3_fase == 3 && keyboard_check_pressed(ord("E")) {
        marcar_quest_completa(2);
        fechar_quest_overlay();
    }
}