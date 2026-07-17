// =====================================================================================
// 🛡️ BLOCO DE SEGURANÇA (Inicialização Automática)
// Impede travamentos caso alguma variável não tenha sido criada no Create Event.
// =====================================================================================
if (!variable_instance_exists(id, "guia_aberto")) { guia_aberto = false; }
if (!variable_instance_exists(id, "guia_pagina_atual")) { guia_pagina_atual = 0; }
if (!variable_instance_exists(id, "guia_num_paginas")) { guia_num_paginas = 1; }
if (!variable_instance_exists(id, "pausado")) { pausado = false; }
if (!variable_instance_exists(id, "pause_aba")) { pause_aba = 0; }
if (!variable_instance_exists(id, "save_slot_existe")) { save_slot_existe = false; }
if (!variable_instance_exists(id, "tablet_aberto")) { tablet_aberto = false; }
if (!variable_instance_exists(id, "tablet_aba")) { tablet_aba = -1; }
if (!variable_instance_exists(id, "tablet_recebido")) { tablet_recebido = false; }
if (!variable_instance_exists(id, "quest_overlay_ativa")) { quest_overlay_ativa = -1; }
if (!variable_instance_exists(id, "hud_moeda_anim")) { hud_moeda_anim = 0; }
if (!variable_instance_exists(id, "hud_npc_perto")) { hud_npc_perto = false; }
if (!variable_instance_exists(id, "hud_npc_nome")) { hud_npc_nome = ""; }
if (!variable_instance_exists(id, "hud_npc_perto_proximo_frame")) { hud_npc_perto_proximo_frame = false; }
if (!variable_instance_exists(id, "hud_npc_nome_proximo_frame")) { hud_npc_nome_proximo_frame = ""; }

// Variáveis específicas da Quest 2 e 3 (caso não existam)
if (!variable_instance_exists(id, "p2_fase")) { p2_fase = 0; }
if (!variable_instance_exists(id, "p2_resposta_correta")) { p2_resposta_correta = 0; }
if (!variable_instance_exists(id, "p2_resposta_selecionada")) { p2_resposta_selecionada = -1; }
if (!variable_instance_exists(id, "p3_fase")) { p3_fase = 0; }
if (!variable_instance_exists(id, "p3_digitacao_completa")) { p3_digitacao_completa = false; }
if (!variable_instance_exists(id, "p3_timer_digitar")) { p3_timer_digitar = 0; }
if (!variable_instance_exists(id, "p3_char_index")) { p3_char_index = 0; }
if (!variable_instance_exists(id, "p3_texto_atual")) { p3_texto_atual = ""; }
if (!variable_instance_exists(id, "p3_relato")) { p3_relato = ""; }
if (!variable_instance_exists(id, "p3_itens_selecionados")) { p3_itens_selecionados = 0; }
// =====================================================================================

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

// =========================================
// CLIQUES NO GUIA
// =========================================
if guia_aberto && mouse_check_button_pressed(mb_left) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var g_w = gw * 0.70;
    var g_x = gw/2 - g_w/2;
    var g_y = 0;

    var btn_w2  = 120;
    var btn_h2  = 44;
    var btn_y2  = gh - btn_h2 - 10;

    // Botão voltar
    if point_in_rectangle(mx, my, g_x+10, g_y+8, g_x+110, g_y+44) {
        guia_aberto   = false;
        tablet_aba    = -1;
        tablet_aberto = true;
        exit;
    }

    // Seta esquerda
    if point_in_rectangle(mx, my, g_x+12, btn_y2, g_x+12+btn_w2, btn_y2+btn_h2) {
        if guia_pagina_atual > 0 {
            guia_pagina_atual--;
        }
        exit;
    }

    // Seta direita
    var btn_dir_x = g_x + g_w - btn_w2 - 12;
    if point_in_rectangle(mx, my, btn_dir_x, btn_y2, btn_dir_x+btn_w2, btn_y2+btn_h2) {
        if guia_pagina_atual < guia_num_paginas-1 {
            guia_pagina_atual++;
        }
        exit;
    }
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

    // Clique nos botões da home (tablet_aba == -1)
    if tablet_aba == -1 {
        var icone_h = 80; var gap = 16;
        var start_y = tela_y + 100;
        var ix = tela_x + 20; var iw = tela_w - 40;
        var i = 0;
        repeat (4) {
            var iy = start_y + i*(icone_h+gap);
            if point_in_rectangle(mx, my, ix, iy, ix+iw, iy+icone_h) {
                if i == 3 {
                    // Guia abre o painel separado
                    tablet_aberto     = false;
                    guia_aberto       = true;
                    guia_pagina_atual = 0;
                } else {
                    tablet_aba = i;
                }
                exit;
            }
            i++;
        }
    }
    
    // Clique nas setas do guia (dentro do tablet se a aba for 3)
    if tablet_aba == 3 {
        var tela_x_guia = tab_x + 22;
        var tela_y_guia = tab_y + 55;
        var tela_w_guia = tab_w - 44;
        var tela_h_guia = tab_h - 110;

        var seta_y  = tela_y_guia + tela_h_guia - 52;
        var seta_w  = 60; var seta_h = 36;

        // Seta esquerda
        if point_in_rectangle(mx, my, tela_x_guia+20, seta_y, tela_x_guia+20+seta_w, seta_y+seta_h) {
            if guia_pagina_atual > 0 {
                guia_pagina_atual--;
            }
        }

        // Seta direita
        if point_in_rectangle(mx, my, tela_x_guia+tela_w_guia-20-seta_w, seta_y, tela_x_guia+tela_w_guia-20, seta_y+seta_h) {
            if guia_pagina_atual < guia_num_paginas-1 {
                guia_pagina_atual++;
            }
        }
    }
}

if quest_overlay_ativa == 1 {
    if p2_fase == 0 && keyboard_check_pressed(ord("E")) {
        p2_fase = 1;
    }

    // Validação acontece aqui, ao clicar na alternativa
    if p2_fase == 1 && mouse_check_button_pressed(mb_left) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
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
        if p3_itens_selecionados == 2 && point_in_rectangle(mx, my, 980, 660, 1240, 704) {
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