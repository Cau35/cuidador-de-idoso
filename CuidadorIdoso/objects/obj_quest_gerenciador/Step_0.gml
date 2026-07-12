dialogo_npc_ativo = false;


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

var dialogo_rolando = false;
if instance_exists(obj_cena_jaleco) {
    if obj_cena_jaleco.dialogo_ativo || obj_cena_jaleco.qz_ativo {
        dialogo_rolando = true;
    }
}

if keyboard_check_pressed(vk_escape) && !dialogo_rolando {
    if quest_overlay_ativa != -1 {
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


hud_npc_perto = hud_npc_perto_proximo_frame;
hud_npc_nome  = hud_npc_nome_proximo_frame;
hud_npc_perto_proximo_frame = false;
hud_npc_nome_proximo_frame  = "";


if keyboard_check_pressed(ord("T")) && tablet_recebido {
    tablet_aberto = !tablet_aberto;
}


if tablet_aberto && mouse_check_button_pressed(mb_left) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
	
    var tab_w = 380; var tab_h = 620;
    var tab_x = display_get_gui_width()/2  - tab_w/2;
    var tab_y = display_get_gui_height()/2 - tab_h/2;
    var tela_x = tab_x+28; var tela_y = tab_y+48;
    var tela_w = tab_w-56; var tela_h = tab_h-120;

    // Fechar X
    if point_in_rectangle(mx, my, tela_x+4, tela_y+4, tela_x+28, tela_y+28) {
        tablet_aberto = false;
        exit;
    }

    // Botão voltar
    if tablet_aba != -1 {
        if point_in_rectangle(mx, my, tela_x+8, tela_y+44, tela_x+72, tela_y+80) {
            tablet_aba = -1;
            exit;
        }
    }

    // Clique nos botões da home
    if tablet_aba == -1 {
        var icone_h = 80; var gap = 24;
        var start_y = tela_y + 100;
        var ix = tela_x+20; var iw = tela_w-40;

        for (var i = 0; i < 3; i++) {
            var iy = start_y + i*(icone_h+gap);
            if point_in_rectangle(mx, my, ix, iy, ix+iw, iy+icone_h) {
                tablet_aba = i;
                exit;
            }
        }
    }
	// Draw GUI — temporário
draw_set_color(c_red);
draw_rectangle(tela_x, tela_y, tela_x+tela_w, tela_y+tela_h, true);
}


if quest_overlay_ativa == 1 {

    if p2_fase == 0 && keyboard_check_pressed(ord("E")) {
        p2_fase = 1;
    }

    // Validação acontece aqui, ao clicar na alternativa
    if p2_fase == 1 && mouse_check_button_pressed(mb_left) {
        var mx = display_mouse_get_x();
        var my = display_mouse_get_y();
        var gw = display_get_gui_width();

        var pront_h = 420;
        var qy = 10 + pront_h + 10 + 44;
        var base_y = qy + 50;
        var alt    = 44;
        var gap    = 8;

        var i = 0;
        repeat (4) {
            var oy = base_y + i*(alt+gap);
            if point_in_rectangle(mx, my, 20, oy, gw-20, oy+alt) {
                p2_resposta_selecionada = i;
                p2_fase = 2; // ← só avança para fase 2 (feedback) aqui

                // Validação explícita
                if i == p2_resposta_correta {
                    ganhar_moedas(20);
                } else {
                    ganhar_moedas(5);
                }
            }
            i++;
        }
    }

    // Fase 2: mostra feedback, espera confirmação para ver tutor
    if p2_fase == 2 {
        if keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left) {
            p2_fase = 3;
        }
    }

    // Fase 3: só fecha com E, e só marca completa aqui
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