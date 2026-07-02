// =========================================
// HUD FIXO — Moedas (superior esquerdo)
// =========================================
var hud_x = 24;
var hud_y = 20;
var hud_w = 180;
var hud_h = 48;

draw_set_alpha(0.85);
draw_set_color(make_color_rgb(15, 20, 30));
draw_rectangle(hud_x, hud_y, hud_x + hud_w, hud_y + hud_h, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(60, 200, 255));
draw_rectangle(hud_x, hud_y, hud_x + hud_w, hud_y + hud_h, true);

var moeda_escala = 1 + (hud_moeda_anim / 12) * 0.4;
if (sprite_exists(spr_icone_moeda)) {
    draw_sprite_ext(spr_icone_moeda, 0,
        hud_x + 28, hud_y + hud_h/2,
        moeda_escala, moeda_escala, 0, c_white, 1);
} else {
    draw_set_color(make_color_rgb(255, 215, 0));
    draw_circle(hud_x + 28, hud_y + hud_h/2, 14 * moeda_escala, false);
    draw_set_color(make_color_rgb(180, 140, 0));
    draw_circle(hud_x + 28, hud_y + hud_h/2, 14 * moeda_escala, true);
}

draw_set_color(hud_moeda_anim > 0 ? make_color_rgb(255, 230, 100) : c_white);
draw_set_font(fnt_dialogo);
draw_set_halign(fa_left);
draw_text(hud_x + 54, hud_y + 12, string(saldo_moedas));

// =========================================
// HUD FIXO — Dicas de tecla (inferior direito)
// =========================================
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var dica_y = gh - 60;

var dica_y = gh - 60;

if tablet_recebido && !tablet_aberto {
    desenhar_dica_tecla(gw - 200, dica_y, "T", "Abrir Tablet");
}

if hud_npc_perto && !tablet_aberto {
    var texto_acao = (hud_npc_nome != "") ? "Falar com " + hud_npc_nome : "Interagir";
  
    desenhar_dica_tecla(gw - 8, dica_y - (tablet_recebido ? 50 : 0), "E", texto_acao);
}
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);

// =========================================
// OVERLAY DO TABLET
// =========================================
if tablet_aberto {
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    var px=140; var py=80; var pw=1000; var ph=560;
    draw_set_color(make_color_rgb(15,20,30));
    draw_rectangle(px,py,px+pw,py+ph,false);
    draw_set_color(make_color_rgb(60,200,255));
    draw_rectangle(px,py,px+pw,py+ph,true);

    var abas = ["Objetivos", "Mensagens", "Inventário", "Conta"];
    var aba_w = pw / 4;
    for (var i = 0; i < 4; i++) {
        var ax = px + i*aba_w;
        var cor_aba = (tablet_aba == i) ? make_color_rgb(30,100,200) : make_color_rgb(25,35,55);
        draw_set_color(cor_aba);
        draw_rectangle(ax, py, ax+aba_w, py+44, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(ax+aba_w/2, py+12, abas[i]);
    }
    draw_set_halign(fa_left);

    var cy = py + 60;
    draw_set_color(c_white);
    draw_set_font(fnt_normal);

    if tablet_aba == 0 {
        draw_text(px+24, cy, "Objetivos:");
        for (var i = 0; i < array_length(objetivos); i++) {
            draw_text(px+40, cy + 36 + i*32, "• " + objetivos[i]);
        }
    } else if tablet_aba == 1 {
        draw_text(px+24, cy, "Mensagens recebidas:");
        var my = cy + 36;
        for (var i = 0; i < array_length(mensagens); i++) {
            draw_set_color(make_color_rgb(120,200,255));
            draw_text(px+40, my, mensagens[i].remetente + ":");
            draw_set_color(c_white);
            draw_text_ext(px+40, my+22, mensagens[i].texto, 22, pw-100);
            my += 70;
        }
    } else if tablet_aba == 2 {
        draw_text(px+24, cy, "Inventário:");
        for (var i = 0; i < array_length(inventario); i++) {
            draw_text(px+40, cy + 36 + i*32, "• " + inventario[i]);
        }
    } else if tablet_aba == 3 {
        draw_text(px+24, cy, "Conta bancária:");
        draw_text(px+40, cy+36, "Saldo: " + string(saldo_moedas) + " moedas");
    }

    var bx = px+pw-44; var by = py+4; var bw=36; var bh=36;
    draw_set_color(make_color_rgb(180,40,40));
    draw_rectangle(bx,by,bx+bw,by+bh,false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(bx+bw/2, by+8, "X");
    draw_set_halign(fa_left);
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);

// =========================================
function desenhar_dica_tecla(_x, _y, _tecla, _label) {
    var tecla_w = 36;
    var tecla_h = 36;
    var caixa_h = 40;

   
    draw_set_font(fnt_normal);
    var texto_w = string_width(_label);
    var caixa_w = tecla_w + texto_w + 32; // padding dos dois lados

    // Garante que não sai da tela pela direita
    var gw = display_get_gui_width();
    var _x_ajustado = min(_x, gw - caixa_w - 8);

    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(15, 20, 30));
    draw_rectangle(_x_ajustado, _y, _x_ajustado + caixa_w, _y + caixa_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(_x_ajustado, _y, _x_ajustado + caixa_w, _y + caixa_h, true);

    // Tecla
    var tx = _x_ajustado + 4;
    var ty = _y + 2;
    draw_set_color(make_color_rgb(230, 230, 235));
    draw_rectangle(tx, ty, tx + tecla_w, ty + tecla_h, false);
    draw_set_color(make_color_rgb(120, 120, 130));
    draw_rectangle(tx, ty, tx + tecla_w, ty + tecla_h, true);
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_set_font(fnt_subtitulo);
    draw_set_halign(fa_center);
    draw_text(tx + tecla_w/2, ty + 4, _tecla);

    // Label
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
    draw_text(tx + tecla_w + 10, _y + 10, _label);
}
// =========================================
// MENU DE PAUSE
// =========================================
if pausado {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    // Overlay escuro
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    if pause_aba == 0 { desenhar_pause_menu(); }
    if pause_aba == 1 { desenhar_confirmacao_save(); }
    if pause_aba == 2 { desenhar_confirmacao_sair(); }
}

// =========================================
function desenhar_pause_menu() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var pw = 360; var ph = 380;
    var px = gw/2 - pw/2; var py = gh/2 - ph/2;

    // Painel
    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.97);
    draw_rectangle(px, py, px+pw, py+ph, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(px, py, px+pw, py+ph, true);

    // Título
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(px+pw/2, py+24, "PAUSADO");

    // Linha separadora
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_line(px+24, py+62, px+pw-24, py+62);

    // Botões
    var botoes = ["Continuar", "Salvar Jogo", "Carregar Jogo", "Sair para o Menu"];
    var btn_w = pw - 60; var btn_h = 48; var btn_gap = 16;
    var btn_start_y = py + 88;

    for (var i = 0; i < array_length(botoes); i++) {
        var bx = px + 30;
        var by = btn_start_y + i * (btn_h + btn_gap);
        var hover = point_in_rectangle(
            display_mouse_get_x(), display_mouse_get_y(),
            bx, by, bx+btn_w, by+btn_h);

        draw_set_color(hover ? make_color_rgb(30,100,200) : make_color_rgb(25, 35, 60));
        draw_rectangle(bx, by, bx+btn_w, by+btn_h, false);
        draw_set_color(hover ? c_white : make_color_rgb(180, 210, 255));
        draw_rectangle(bx, by, bx+btn_w, by+btn_h, true);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_text(bx+btn_w/2, by+btn_h/2-10, botoes[i]);
    }

    // Dica de tecla
    draw_set_color(make_color_rgb(100, 130, 180));
    draw_set_font(fnt_normal);
    draw_text(px+pw/2, py+ph-28, "[ESC] para continuar");
    draw_set_halign(fa_left);
}

// =========================================
function desenhar_confirmacao_save() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var pw = 400; var ph = 200;
    var px = gw/2 - pw/2; var py = gh/2 - ph/2;

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.97);
    draw_rectangle(px, py, px+pw, py+ph, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(px, py, px+pw, py+ph, true);

    draw_set_color(c_white);
    draw_set_font(fnt_subtitulo);
    draw_set_halign(fa_center);
    draw_text(px+pw/2, py+24, "Salvar o jogo?");

    draw_set_font(fnt_normal);
    draw_set_color(make_color_rgb(160, 190, 220));
    draw_text(px+pw/2, py+68,
        save_slot_existe ? "Isso vai sobrescrever o save anterior." : "Nenhum save encontrado. Criando novo.");

    // Botão Confirmar
    var bx1 = px+30; var by1 = py+120; var bw1 = 150; var bh1 = 44;
    var hover1 = point_in_rectangle(display_mouse_get_x(), display_mouse_get_y(),
        bx1, by1, bx1+bw1, by1+bh1);
    draw_set_color(hover1 ? make_color_rgb(20,140,60) : make_color_rgb(15,100,45));
    draw_rectangle(bx1, by1, bx1+bw1, by1+bh1, false);
    draw_set_color(c_white);
    draw_text(bx1+bw1/2, by1+12, "Salvar ✓");

    // Botão Cancelar
    var bx2 = px+pw-180; var by2 = py+120; var bw2 = 150; var bh2 = 44;
    var hover2 = point_in_rectangle(display_mouse_get_x(), display_mouse_get_y(),
        bx2, by2, bx2+bw2, by2+bh2);
    draw_set_color(hover2 ? make_color_rgb(160,30,30) : make_color_rgb(100,20,20));
    draw_rectangle(bx2, by2, bx2+bw2, by2+bh2, false);
    draw_set_color(c_white);
    draw_text(bx2+bw2/2, by2+12, "Cancelar ✗");

    draw_set_halign(fa_left);
}

// =========================================
function desenhar_confirmacao_sair() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var pw = 400; var ph = 200;
    var px = gw/2 - pw/2; var py = gh/2 - ph/2;

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.97);
    draw_rectangle(px, py, px+pw, py+ph, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(200, 60, 60));
    draw_rectangle(px, py, px+pw, py+ph, true);

    draw_set_color(c_white);
    draw_set_font(fnt_subtitulo);
    draw_set_halign(fa_center);
    draw_text(px+pw/2, py+24, "Sair para o menu?");

    draw_set_font(fnt_normal);
    draw_set_color(make_color_rgb(255, 180, 180));
    draw_text(px+pw/2, py+68, "Progresso não salvo será perdido.");

    var bx1 = px+30; var by1 = py+120; var bw1 = 150; var bh1 = 44;
    var hover1 = point_in_rectangle(display_mouse_get_x(), display_mouse_get_y(),
        bx1, by1, bx1+bw1, by1+bh1);
    draw_set_color(hover1 ? make_color_rgb(160,30,30) : make_color_rgb(100,20,20));
    draw_rectangle(bx1, by1, bx1+bw1, by1+bh1, false);
    draw_set_color(c_white);
    draw_text(bx1+bw1/2, by1+12, "Sair");

    var bx2 = px+pw-180; var by2 = py+120; var bw2 = 150; var bh2 = 44;
    var hover2 = point_in_rectangle(display_mouse_get_x(), display_mouse_get_y(),
        bx2, by2, bx2+bw2, by2+bh2);
    draw_set_color(hover2 ? make_color_rgb(30,100,200) : make_color_rgb(20,60,140));
    draw_rectangle(bx2, by2, bx2+bw2, by2+bh2, false);
    draw_set_color(c_white);
    draw_text(bx2+bw2/2, by2+12, "Cancelar");

    draw_set_halign(fa_left);
}