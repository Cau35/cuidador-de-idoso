
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
    var gw = display_get_gui_width();  // agora retorna 1280
    var gh = display_get_gui_height(); // agora retorna 720

    // Fundo semitransparente
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(230, 237, 245));
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    // Prontuário centralizado
    var pront_x = 20;
    var pront_y = 10;
    var pront_w = gw - 40;
    var pront_h = 420;

    draw_sprite_stretched(spr_prontuario_overlay, 0,
        pront_x, pront_y, pront_w, pront_h);

    // Cabeçalho
    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(pront_x, pront_y, pront_x+pront_w, pront_y+44, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(gw/2, pront_y+10, "PRONTUÁRIO DE CUIDADOS  —  Paciente: Seu Manoel");
    draw_set_halign(fa_left);

    // Colunas
    var col_w = pront_w / 3;
    for (var d = 0; d < 3; d++) {
        var cx = pront_x + d*col_w;
        var cy = pront_y + 44;

        draw_set_color(make_color_rgb(180,200,230));
        draw_rectangle(cx, cy, cx+col_w, pront_y+pront_h, true);
        draw_set_color(make_color_rgb(235,242,255));
        draw_rectangle(cx, cy, cx+col_w, cy+34, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_center);
        draw_text(cx+col_w/2, cy+8, p2_dia_titulo[d]);
        draw_set_halign(fa_left);

        var regs = p2_registros[d];
        for (var r = 0; r < array_length(regs); r++) {
            var ry = cy + 34 + r*80;
            var linha = regs[r];
            draw_set_color(r mod 2==0
                ? make_color_rgb(240,246,255) : c_white);
            draw_rectangle(cx+1, ry, cx+col_w-1, ry+80, false);
            if string_pos("Agitado", linha) > 0
                draw_set_color(make_color_rgb(200,50,50));
            else if string_pos("Calmo", linha) > 0
                draw_set_color(make_color_rgb(30,140,60));
            else if string_pos("Lanche: Suco", linha) > 0
                draw_set_color(make_color_rgb(180,100,0));
            else
                draw_set_color(make_color_rgb(30,30,60));
            draw_set_font(fnt_normal);
            draw_text_ext(cx+10, ry+10, linha, 22, col_w-18);
        }
    }

    // Botão analisar (fase 0)
    if p2_fase == 0 {
        var bx = gw/2-100; var by = pront_y+pront_h+10;
        var hover = point_in_rectangle(
            device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
            bx, by, bx+200, by+40);
        draw_set_color(hover ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
        draw_rectangle(bx, by, bx+200, by+40, false);
        draw_set_color(c_white);
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_center);
        draw_text(gw/2, by+10, "Analisar Padroes [E]");
        draw_set_halign(fa_left);
    }

    // Pergunta e alternativas (fase 1 e 2)
    if p2_fase >= 1 {
        var qy = pront_y + pront_h + 10;

        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(20, qy, gw-20, qy+44, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(30, qy+6,
            "Qual variável parece estar correlacionada com os episódios de agitação?",
            20, gw-60);

        var base_y = qy + 50;
        var alt    = 44;
        var gap    = 8;

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
                    device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
                    20, oy, gw-20, oy+alt);
                cor = hover ? make_color_rgb(200,220,255) : make_color_rgb(240,246,255);
            }
            draw_set_color(cor);
            draw_rectangle(20, oy, gw-20, oy+alt, false);
            draw_set_color(make_color_rgb(150,180,220));
            draw_rectangle(20, oy, gw-20, oy+alt, true);
            draw_set_color(make_color_rgb(20,30,60));
            draw_set_font(fnt_normal);
            draw_text_ext(36, oy+8, p2_opcoes[i], 20, gw-72);
        }
    }

    // Feedback (fase 2)
    if p2_fase == 2 {
        var acertou = (p2_resposta_selecionada == p2_resposta_correta);
        var fy = gh - 48;
        draw_set_color(acertou
            ? make_color_rgb(20,100,40) : make_color_rgb(140,30,30));
        draw_rectangle(20, fy, gw-20, fy+40, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text(30, fy+10, acertou
            ? "Correto! Pressione [E] para ver a analise."
            : "Observe o lanche nos dias de agitacao. [E] para continuar.");
    }

    // Tutor (fase 3)
    if p2_fase == 3 {
        draw_set_alpha(0.65);
        draw_set_color(c_black);
        draw_rectangle(0, 0, gw, gh, false);
        draw_set_alpha(1);

        var tpx=60; var tpy=60; var tpw=gw-120; var tph=gh-120;
        draw_set_color(c_white);
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, true);
        draw_rectangle(tpx, tpy, tpx+tpw, tpy+48, false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(tpx+tpw/2, tpy+10, "Analise do Professor");
        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(tpx+24, tpy+62, p2_texto_tutor, 28, tpw-48);
        draw_set_color(make_color_rgb(100,130,180));
        draw_set_halign(fa_right);
        draw_text(tpx+tpw-16, tpy+tph-20, "[E] Concluir Quest");
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
            var hover=point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),980,660,1240,704);
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

            var hover=point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),960,684,1230,716);
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
   if tablet_aberto {
    gw = display_get_gui_width();
    gh = display_get_gui_height();

    // Overlay escuro
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    // === TABLET VERTICAL ===
    // Dimensões do sprite do tablet (vertical)
    var tab_w = 380;
    var tab_h = 620;
    var tab_x = gw/2 - tab_w/2;
    var tab_y = gh/2 - tab_h/2;

    // Sprite do tablet como fundo
    draw_sprite_stretched(spr_tablet_fundo, 0, tab_x, tab_y, tab_w, tab_h);

    // Área da tela (tela preta dentro do sprite)
    // Ajuste esses valores para bater com a área preta do seu sprite
    var tela_x = tab_x + 28;
    var tela_y = tab_y + 48;
    var tela_w = tab_w - 56;
    var tela_h = tab_h - 120;

    // Fundo da tela
    draw_set_color(make_color_rgb(10, 10, 20));
    draw_rectangle(tela_x, tela_y, tela_x+tela_w, tela_y+tela_h, false);

    // Barra de status (topo da tela)
    draw_set_color(make_color_rgb(20, 20, 35));
    draw_rectangle(tela_x, tela_y, tela_x+tela_w, tela_y+36, false);

    // Moedas na barra de status
    draw_set_color(make_color_rgb(255, 215, 0));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_right);
    draw_text(tela_x+tela_w-10, tela_y+8, string(saldo_moedas) + " moedas");
    draw_set_halign(fa_left);

    // Botão fechar X
    draw_set_color(make_color_rgb(180, 40, 40));
    draw_rectangle(tela_x+4, tela_y+4, tela_x+28, tela_y+28, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(tela_x+16, tela_y+7, "X");
    draw_set_halign(fa_left);

    // === CONTEÚDO DA TELA ===
    if tablet_aba == -1 {
        desenhar_tablet_home(tela_x, tela_y, tela_w, tela_h);
    } else if tablet_aba == 0 {
        desenhar_tablet_missoes(tela_x, tela_y, tela_w, tela_h);
    } else if tablet_aba == 1 {
        desenhar_tablet_mensagens(tela_x, tela_y, tela_w, tela_h);
    } else if tablet_aba == 2 {
        desenhar_tablet_inventario(tela_x, tela_y, tela_w, tela_h);
    }

    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}

// =========================================
function desenhar_tablet_home(_tx, _ty, _tw, _th) {
    var cx = _tx + _tw/2;

    // Saudação
    draw_set_color(make_color_rgb(180, 180, 220));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(cx, _ty+48, "Bem-vinda!");

    // 3 ícones em coluna (vertical, um abaixo do outro)
    var icone_w = 160; var icone_h = 80;
    var gap = 24;
    var start_y = _ty + 100;

    // Sprites dos ícones — troque pelos nomes reais
    var spr_icones  = [spr_icone_missoes, spr_icone_mensagens, spr_icone_inventario];
    var nomes_abas  = ["Missoes", "Mensagens", "Inventario"];
    var cor_fundos  = [
        make_color_rgb(20, 80, 50),
        make_color_rgb(20, 50, 120),
        make_color_rgb(100, 60, 10)
    ];
    var cor_hover = [
        make_color_rgb(30, 120, 75),
        make_color_rgb(30, 80, 180),
        make_color_rgb(150, 90, 15)
    ];

    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    for (var i = 0; i < 3; i++) {
        var iy = start_y + i*(icone_h+gap);
        var ix = _tx + 20;
        var iw = _tw - 40;

        var hover = point_in_rectangle(mx, my, ix, iy, ix+iw, iy+icone_h);

        // Fundo do botão
        draw_set_color(hover ? cor_hover[i] : cor_fundos[i]);
        draw_rectangle(ix, iy, ix+iw, iy+icone_h, false);
        draw_set_color(make_color_rgb(80, 80, 120));
        draw_rectangle(ix, iy, ix+iw, iy+icone_h, true);

        // Ícone (sprite) à esquerda
        if sprite_exists(spr_icones[i]) {
            draw_sprite_stretched(spr_icones[i], 0,
                ix+10, iy+10, 60, 60);
        }

        // Nome à direita do ícone
        draw_set_color(c_white);
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_left);
        draw_text(ix+80, iy+icone_h/2-10, nomes_abas[i]);

        // Seta indicadora
        draw_set_color(make_color_rgb(150, 150, 200));
        draw_set_halign(fa_right);
        draw_text(ix+iw-10, iy+icone_h/2-10, ">");

        // Badge de mensagem não lida
        if i == 1 && array_length(mensagens) > 0 {
            draw_set_color(make_color_rgb(220, 50, 50));
            draw_circle(ix+iw-24, iy+14, 12, false);
            draw_set_color(c_white);
            draw_set_font(fnt_normal);
            draw_set_halign(fa_center);
            draw_text(ix+iw-24, iy+5,
                string(min(array_length(mensagens), 9)));
        }
    }

    draw_set_halign(fa_left);
}

// =========================================
function desenhar_tablet_missoes(_tx, _ty, _tw, _th) {
    desenhar_cabecalho_aba(_tx, _ty, _tw, "Missoes");

    var cy = _ty + 88;
    var lx = _tx + 12;
    var lw = _tw - 24;

    // Fundo estilo bloco de notas
    draw_set_color(make_color_rgb(255, 254, 230));
    draw_rectangle(lx, cy, lx+lw, _ty+_th, false);

    // Linha vermelha vertical
    draw_set_color(make_color_rgb(220, 80, 80));
    draw_set_alpha(0.5);
    draw_line(lx+40, cy, lx+40, _ty+_th);
    draw_set_alpha(1);

    // Linhas horizontais
    draw_set_color(make_color_rgb(180, 200, 240));
    draw_set_alpha(0.4);
    for (var l = 0; l < 16; l++) {
        draw_line(lx, cy+8+l*36, lx+lw, cy+8+l*36);
    }
    draw_set_alpha(1);

    var nomes_missoes = [
        "Prof. Decomposicao",
        "Prof. Padroes",
        "Prof. Abstracao",
        "Prof. Algoritmos",
        "Avaliacao Final"
    ];

    for (var i = 0; i < 5; i++) {
        var my_item = cy + 14 + i*44;
        var completo = (i < 4) ? quest_completa[i] : integradora_completa;

        // Checkbox
        draw_set_color(completo
            ? make_color_rgb(30, 150, 70) : make_color_rgb(200, 195, 160));
        draw_rectangle(lx+48, my_item, lx+68, my_item+20, false);
        draw_set_color(make_color_rgb(140, 130, 100));
        draw_rectangle(lx+48, my_item, lx+68, my_item+20, true);

        if completo {
            draw_set_color(c_white);
            draw_set_font(fnt_subtitulo);
            draw_set_halign(fa_center);
            draw_text(lx+58, my_item+1, "v");
        }

        // Texto
        draw_set_halign(fa_left);
        draw_set_font(fnt_normal);
        if completo {
            draw_set_color(make_color_rgb(130, 120, 90));
            draw_text(lx+76, my_item+1, nomes_missoes[i]);
            // Risco
            var tw = string_width(nomes_missoes[i]);
            draw_set_color(make_color_rgb(100, 90, 60));
            draw_line(lx+76, my_item+10, lx+76+tw, my_item+10);
        } else {
            draw_set_color(make_color_rgb(40, 30, 10));
            draw_text(lx+76, my_item+1, nomes_missoes[i]);
        }
    }
}

// =========================================
function desenhar_tablet_mensagens(_tx, _ty, _tw, _th) {
    desenhar_cabecalho_aba(_tx, _ty, _tw, "Mensagens");

    // Fundo estilo chat
    draw_set_color(make_color_rgb(25, 28, 45));
    draw_rectangle(_tx+12, _ty+88, _tx+_tw-12, _ty+_th, false);

    var my_msg = _ty + 100;

    for (var i = array_length(mensagens)-1; i >= 0; i--) {
        if my_msg > _ty+_th-60 break;
        var msg = mensagens[i];

        // Avatar circular
        draw_set_color(make_color_rgb(60, 80, 160));
        draw_circle(_tx+32, my_msg+22, 18, false);
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(_tx+32, my_msg+13,
            string_upper(string_copy(msg.remetente, 1, 1)));

        // Balão
        var bx = _tx+58;
        var bw = _tw - 80;
        var texto_h = string_height_ext(msg.texto, 18, bw-16);
        var bh = max(44, texto_h + 28);

        draw_set_color(make_color_rgb(40, 50, 90));
        draw_rectangle(bx, my_msg, bx+bw, my_msg+bh, false);
        draw_set_color(make_color_rgb(70, 90, 150));
        draw_rectangle(bx, my_msg, bx+bw, my_msg+bh, true);

        // Remetente
        draw_set_color(make_color_rgb(140, 170, 255));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text(bx+8, my_msg+4, msg.remetente);

        // Texto
        draw_set_color(c_white);
        draw_text_ext(bx+8, my_msg+22, msg.texto, 18, bw-16);

        my_msg += bh + 10;
    }
}

// =========================================
function desenhar_tablet_inventario(_tx, _ty, _tw, _th) {
    desenhar_cabecalho_aba(_tx, _ty, _tw, "Inventario");

    var cx = _tx + 12;
    var cy = _ty + 100;
    var item_w = 90; var item_h = 90;
    var gap = 12;
    var por_linha = floor((_tw-24) / (item_w+gap));

    for (var i = 0; i < array_length(inventario); i++) {
        var col = i mod por_linha;
        var lin = floor(i / por_linha);
        var ix = cx + col*(item_w+gap);
        var iy = cy + lin*(item_h+gap+20);

        // Fundo do item
        draw_set_color(make_color_rgb(35, 40, 65));
        draw_rectangle(ix, iy, ix+item_w, iy+item_h, false);
        draw_set_color(make_color_rgb(80, 90, 140));
        draw_rectangle(ix, iy, ix+item_w, iy+item_h, true);

        // Sprite do item
        var spr_item = asset_get_index(
            "spr_item_" + string_lower(inventario[i]));
        if sprite_exists(spr_item) {
            draw_sprite_stretched(spr_item, 0,
                ix+10, iy+10, item_w-20, item_h-20);
        } else {
            draw_set_color(make_color_rgb(100, 120, 200));
            draw_set_font(fnt_subtitulo);
            draw_set_halign(fa_center);
            draw_text(ix+item_w/2, iy+item_h/2-14,
                string_upper(string_copy(inventario[i], 1, 1)));
        }

        // Nome
        draw_set_color(make_color_rgb(180, 190, 220));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(ix+item_w/2, iy+item_h+2, inventario[i]);
    }

    draw_set_halign(fa_left);
}

// =========================================
function desenhar_cabecalho_aba(_tx, _ty, _tw, _titulo) {
    // Barra da aba
    draw_set_color(make_color_rgb(30, 35, 60));
    draw_rectangle(_tx, _ty+36, _tx+_tw, _ty+88, false);

    // Botão voltar
    draw_set_color(make_color_rgb(60, 80, 150));
    draw_rectangle(_tx+8, _ty+44, _tx+72, _ty+80, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(_tx+40, _ty+52, "< Voltar");

    // Título
    draw_set_color(c_white);
    draw_set_font(fnt_subtitulo);
    draw_text(_tx+_tw/2, _ty+52, _titulo);
    draw_set_halign(fa_left);
}


    
    draw_set_color(make_color_rgb(255,215,0));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
   

    
   
}

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
            device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
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
    var hover1 = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
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
    var hover1 = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
        bx1, by1, bx1+bw1, by1+bh1);
    draw_set_color(hover1 ? make_color_rgb(160,30,30) : make_color_rgb(100,20,20));
    draw_rectangle(bx1, by1, bx1+bw1, by1+bh1, false);
    draw_set_color(c_white);
    draw_text(bx1+bw1/2, by1+12, "Sair");

    var bx2 = px+pw-180; var by2 = py+120; var bw2 = 150; var bh2 = 44;
    var hover2 = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),
        bx2, by2, bx2+bw2, by2+bh2);
    draw_set_color(hover2 ? make_color_rgb(30,100,200) : make_color_rgb(20,60,140));
    draw_rectangle(bx2, by2, bx2+bw2, by2+bh2, false);
    draw_set_color(c_white);
    draw_text(bx2+bw2/2, by2+12, "Cancelar");

    draw_set_halign(fa_left);
}


