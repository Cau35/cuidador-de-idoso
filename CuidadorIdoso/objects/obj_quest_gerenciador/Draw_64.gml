
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


var gw = display_get_gui_width();
var gh = display_get_gui_height();


var dica_y = gh - 60;


if tablet_recebido && !tablet_aberto {
    desenhar_dica_tecla(gw - 200, dica_y, "T", "Abrir Tablet");
}

if hud_npc_perto && !tablet_aberto {
    var texto_acao = (hud_npc_nome != "") ? "INTERAGIR" + hud_npc_nome : "Interagir";
  
    desenhar_dica_tecla(gw - 8, dica_y - (tablet_recebido ? 50 : 0), "E", texto_acao);
}
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);


if quest_overlay_ativa == 1 { desenhar_overlay_prontuario(); }
if quest_overlay_ativa == 2 { desenhar_overlay_plantao(); }


function desenhar_overlay_prontuario() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var ex = gw / 1280; 
    var ey = gh / 720; 

    // Fundo
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(230,237,245));
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    // Sprite do prontuário
    var px = 40*ex; var py = 30*ey;
    var pw = 1200*ex; var ph = 410*ey;
    draw_sprite_stretched(spr_prontuario_overlay, 0, px, py, pw, ph);

    // Cabeçalho
    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(px, py, px+pw, py+44*ey, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text_transformed(gw/2, py+10*ey,
        "PRONTUÁRIO DE CUIDADOS  —  Paciente: Seu Manoel",
        ex, ey, 0);

    // Colunas dos dias
    var col_w = pw / 3;
    for (var d = 0; d < 3; d++) {
        var cx = px + d*col_w;
        var cy = py + 44*ey;

        draw_set_color(make_color_rgb(180,200,230));
        draw_rectangle(cx, cy, cx+col_w, py+ph, true);
        draw_set_color(make_color_rgb(235,242,255));
        draw_rectangle(cx, cy, cx+col_w, cy+34*ey, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_center);
        draw_text_transformed(cx+col_w/2, cy+8*ey,
            p2_dia_titulo[d], ex, ey, 0);
        draw_set_halign(fa_left);

        var regs = p2_registros[d];
        for (var r = 0; r < array_length(regs); r++) {
            var ry = cy + 34*ey + r*80*ey;
            var linha = regs[r];
            draw_set_color(r mod 2==0
                ? make_color_rgb(240,246,255) : c_white);
            draw_rectangle(cx+1, ry, cx+col_w-1, ry+80*ey, false);
            if string_pos("Agitado", linha) > 0
                draw_set_color(make_color_rgb(200,50,50));
            else if string_pos("Calmo", linha) > 0
                draw_set_color(make_color_rgb(30,140,60));
            else if string_pos("Lanche: Suco", linha) > 0
                draw_set_color(make_color_rgb(180,100,0));
            else
                draw_set_color(make_color_rgb(30,30,60));
            draw_set_font(fnt_normal);
            draw_text_ext(cx+10*ex, ry+10*ey, linha, 22*ey, col_w-18*ex);
        }
    }

    // Botão analisar (fase 0)
    if p2_fase == 0 {
        var bx = 540*ex; var by = 455*ey;
        var bw = 200*ex; var bh = 44*ey;
        var hover = point_in_rectangle(
            display_mouse_get_x(), display_mouse_get_y(),
            bx, by, bx+bw, by+bh);
        draw_set_color(hover ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
        draw_rectangle(bx, by, bx+bw, by+bh, false);
        draw_set_color(c_white);
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_center);
        draw_text_transformed(bx+bw/2, by+10*ey, "Analisar Padrões [E] →", ex, ey, 0);
        draw_set_halign(fa_left);
    }

    // Pergunta e alternativas (fase 1 e 2)
    if p2_fase >= 1 {
        var qy = 510*ey;
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(40*ex, qy, 1240*ex, qy+8*ey, false);
        draw_set_color(make_color_rgb(235,242,255));
        draw_rectangle(40*ex, qy+8*ey, 1240*ex, gh-4, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_left);
        draw_text_ext(56*ex, qy+12*ey,
            "Ao observar o padrão nos registros de Seu Manoel, qual variável parece estar correlacionada com os episódios de agitação?",
            24*ey, 1160*ex);

        var base_y = 560*ey;
        var alt    = 48*ey;
        var gap    = 12*ey;

        for (var i = 0; i < 4; i++) {
            var oy = base_y + i*(alt+gap);
            var cor;
            if p2_fase == 2 {
                if i == p2_resposta_correta
                    cor = make_color_rgb(20,140,60);
                else if i == p2_resposta_selecionada
                    cor = make_color_rgb(180,30,30);
                else
                    cor = make_color_rgb(240,246,255);
            } else {
                var hover = point_in_rectangle(
                    display_mouse_get_x(), display_mouse_get_y(),
                    40*ex, oy, 1240*ex, oy+alt);
                cor = hover ? make_color_rgb(200,220,255) : make_color_rgb(240,246,255);
            }
            draw_set_color(cor);
            draw_rectangle(40*ex, oy, 1240*ex, oy+alt, false);
            draw_set_color(make_color_rgb(150,180,220));
            draw_rectangle(40*ex, oy, 1240*ex, oy+alt, true);
            draw_set_color(make_color_rgb(20,30,60));
            draw_set_font(fnt_normal);
            draw_text_ext(56*ex, oy+8*ey, p2_opcoes[i], 20*ey, 1160*ex);
        }
    }

    // Feedback (fase 2)
    if p2_fase == 2 {
        var acertou = (p2_resposta_selecionada == p2_resposta_correta);
        draw_set_color(acertou
            ? make_color_rgb(20,100,40) : make_color_rgb(140,30,30));
        draw_rectangle(40*ex, gh-44*ey, 1240*ex, gh-4, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(56*ex, gh-38*ey,
            acertou
                ? "Correto! O padrao esta no lanche. Pressione [E] para ver a analise."
                : "Observe novamente o lanche nos dias de agitacao. Pressione [E] para continuar.",
            -1, 1160*ex);
    }

    // Tutor (fase 3)
    if p2_fase == 3 {
        draw_set_alpha(0.65);
        draw_set_color(c_black);
        draw_rectangle(0, 0, gw, gh, false);
        draw_set_alpha(1);

        var tpx = 100*ex; var tpy = 80*ey;
        var tpw = 1080*ex; var tph = 540*ey;
        draw_set_color(c_white);
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, true);
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+48*ey, false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text_transformed(tpx+tpw/2, tpy+10*ey,
            "Analise do Professor", ex, ey, 0);
        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(tpx+24*ex, tpy+62*ey, p2_texto_tutor, 28*ey, tpw-48*ex);
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_titulo);
        draw_text_ext(tpx+24*ex, tpy+tph-80*ey,
            "Reconhecimento de Padroes: identificar regularidades nos registros clinicos.",
            -1, tpw-48*ex);
        draw_set_color(make_color_rgb(100,130,180));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_right);
        draw_text_transformed(tpx+tpw-16*ex, tpy+tph-20*ey,
            "[E] Concluir Quest", ex, ey, 0);
        draw_set_halign(fa_left);
    }
}
// =========================================
function desenhar_overlay_plantao() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(28,36,56));
    draw_rectangle(0,0,gw,gh,false);
    draw_set_alpha(1);

    // Fase 0 — Relato com digitação
    if p3_fase == 0 {
        var sw = sprite_get_width(spr_eliza);
        var sh = sprite_get_height(spr_eliza);
        var escala = 520/sh;
        draw_sprite_ext(spr_eliza,0,40,80,escala,escala,0,c_white,1);

        var cx=360; var cy=80; var cw=880; var ch=520;
        draw_set_color(make_color_rgb(240,246,255));
        draw_rectangle(cx,cy,cx+cw,cy+ch,false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(cx,cy,cx+cw,cy+ch,true);
        draw_rectangle(cx,cy,cx+cw,cy+38,false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_left);
        draw_text(cx+16,cy+8,"Colega de Plantão:");
        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_normal);
        draw_text_ext(cx+16,cy+52,p3_texto_atual,26,cw-32);

        draw_set_color(make_color_rgb(120,140,180));
        draw_set_halign(fa_right);
        draw_text(cx+cw-12,cy+ch-28,
            p3_digitacao_completa ? "[E] Abrir Prontuário →" : "[E/Clique] Pular digitação");
        draw_set_halign(fa_left);
    }

    // Fase 1 — Seleção de itens
    if p3_fase >= 1 && p3_fase <= 2 {
        draw_sprite_stretched(spr_fundo_prontuario,0,40,20,1200,290);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(40,20,1240,58,false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(640,30,"PRONTUÁRIO DE ENTRADA — Seu João | Leito 4 | Turno: Noite");
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(40,300,1240,308,false);
        draw_set_color(c_white);
        draw_set_font(fnt_subtitulo);
        draw_text(640,312,"Quais itens você adiciona ao Prontuário Clínico para monitoramento noturno?");
        draw_set_color(p3_itens_selecionados==2
            ? make_color_rgb(30,140,60) : make_color_rgb(200,200,50));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_right);
        draw_text(1228,312,string(p3_itens_selecionados)+" / 2 selecionados");
        draw_set_halign(fa_left);

        for (var i=0; i<6; i++) {
            var iy = 340+i*56;
            var sel = p3_itens_sel[i];
            var cor_item;
            if p3_fase == 2 {
                if p3_itens_corretos[i] cor_item = make_color_rgb(30,140,60);
                else if sel cor_item = make_color_rgb(180,30,30);
                else cor_item = make_color_rgb(240,246,255);
            } else {
                cor_item = sel ? make_color_rgb(30,100,200) : make_color_rgb(240,246,255);
            }
            draw_set_color(cor_item);
            draw_rectangle(60,iy,1220,iy+50,false);
            draw_set_color(make_color_rgb(150,180,220));
            draw_rectangle(60,iy,1220,iy+50,true);

            // Checkbox
            draw_set_color(sel ? make_color_rgb(30,100,200) : c_white);
            draw_rectangle(76,iy+15,96,iy+35,false);
            draw_set_color(make_color_rgb(80,120,180));
            draw_rectangle(76,iy+15,96,iy+35,true);
            if sel {
                draw_set_color(c_white);
                draw_set_font(fnt_titulo);
                draw_set_halign(fa_center);
                draw_text(86,iy+16,"✓");
            }
            draw_set_color((p3_fase==2 && (p3_itens_corretos[i]||sel)) ? c_white : make_color_rgb(20,30,60));
            draw_set_font(fnt_normal);
            draw_set_halign(fa_left);
            draw_text_ext(106,iy+10,p3_textos_itens[i],20,1090);
        }

        // Botão confirmar
        if p3_fase == 1 && p3_itens_selecionados == 2 {
            var hover=point_in_rectangle(display_mouse_get_x(),display_mouse_get_y(),980,660,1240,704);
            draw_set_color(hover ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
            draw_rectangle(980,660,1240,704,false);
            draw_set_color(c_white);
            draw_set_font(fnt_subtitulo);
            draw_set_halign(fa_center);
            draw_text(1110,670,"Confirmar →");
            draw_set_halign(fa_left);
        }

        // Feedback fase 2
        if p3_fase == 2 {
            draw_set_color(p3_acertou ? make_color_rgb(20,100,40) : make_color_rgb(140,30,30));
            draw_rectangle(40,684,1240,716,false);
            draw_set_color(c_white);
            draw_set_font(fnt_normal);
            draw_set_halign(fa_left);
            draw_text(56,693, p3_acertou
                ? "✓ Correto! Tosse seca e urina alterada são sinais clínicos. [E] ver análise."
                : "✗ Foque nos sintomas de risco à saúde. Clique em 'Ver análise' para entender.");

            var hover=point_in_rectangle(display_mouse_get_x(),display_mouse_get_y(),960,684,1230,716);
            draw_set_color(hover ? make_color_rgb(60,140,255) : make_color_rgb(30,100,200));
            draw_rectangle(960,684,1230,716,false);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_text(1095,693,"Ver análise →");
            draw_set_halign(fa_left);
        }
    }

    // Fase 3 — Tutor
    if p3_fase == 3 {
        draw_set_alpha(0.65);
        draw_set_color(c_black);
        draw_rectangle(0,0,gw,gh,false);
        draw_set_alpha(1);

        var px=100; var py=80; var pw=1080; var ph=540;
        draw_set_color(c_white);
        draw_rectangle(px,py,px+pw,py+ph,false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(px,py,px+pw,py+ph,true);
        draw_rectangle(px,py,px+pw,py+48,false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(px+pw/2,py+10,"Análise do Professor");
        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(px+24,py+62,p3_texto_tutor,28,pw-48);
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_titulo);
        draw_text_ext(px+24,py+ph-80,
            "Abstração: extrair apenas os dados essenciais de um relato não-estruturado.",
            -1,pw-48);
        draw_set_color(make_color_rgb(100,130,180));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_right);
        draw_text(px+pw-16,py+ph-20,"[E] Concluir Quest ✓");
        draw_set_halign(fa_left);
    }
}




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
    var gw_1= display_get_gui_width();
    var gh_1 = display_get_gui_height();

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

        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_text(bx+btn_w/2, by+btn_h/2-10, botoes[i]);
    }

    
    draw_set_color(make_color_rgb(100, 130, 180));
    draw_set_font(fnt_normal);
    draw_text(px+pw/2, py+ph-28, "[ESC] para continuar");
    draw_set_halign(fa_left);
}


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


var mx = display_mouse_get_x();
var my = display_mouse_get_y();

// Mira no cursor
draw_set_color(c_red);
draw_line(mx-10, my, mx+10, my);
draw_line(mx, my-10, mx, my+10);
draw_circle(mx, my, 4, false);

// Coordenadas em texto
draw_set_color(c_yellow);
draw_set_font(fnt_normal);
draw_set_halign(fa_left);
draw_text(mx+12, my-8, "X=" + string(mx) + "  Y=" + string(my));