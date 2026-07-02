
var dialogo_rolando = (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo);

// No STEP EVENT — detecta clique no pause manualmente
if pausado && mouse_check_button_pressed(mb_left) {
    var mx = display_mouse_get_x();
    var my = display_mouse_get_y();
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
    pausado = !pausado;
    pause_aba = 0;
    if tablet_aberto { tablet_aberto = false; }
}




if hud_moeda_anim > 0 {
    hud_moeda_anim--;
}

// Atualização segura da flag de NPC próximo (evita problema de ordem de execução)
hud_npc_perto = hud_npc_perto_proximo_frame;
hud_npc_nome  = hud_npc_nome_proximo_frame;
hud_npc_perto_proximo_frame = false;
hud_npc_nome_proximo_frame  = "";

// Tecla para abrir/fechar o tablet
if keyboard_check_pressed(ord("T")) && tablet_recebido {
    tablet_aberto = !tablet_aberto;
}