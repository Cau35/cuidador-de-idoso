var gw = display_get_gui_width();
var gh = display_get_gui_height();

if dialogo_ativo {
    draw_set_alpha(0.35);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    var falante  = obter_fala_falante();
    var eh_aluna = (falante == "aluna");

    var retrato_sprite = eh_aluna ? spr_aluna : spr_professora;
    var retrato_w = 320; var retrato_h = 420;
    var retrato_x = eh_aluna ? 40 : gw - 40 - retrato_w;
    var retrato_y = gh - retrato_h - 180;

    draw_sprite_stretched(retrato_sprite, 0, retrato_x, retrato_y, retrato_w, retrato_h);

    var caixa_x = 40; var caixa_y = gh - 170;
    var caixa_w = gw - 80; var caixa_h = 150;

    draw_set_color(make_color_rgb(15, 20, 30));
    draw_set_alpha(0.95);
    draw_rectangle(caixa_x, caixa_y, caixa_x+caixa_w, caixa_y+caixa_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(60, 200, 255));
    draw_rectangle(caixa_x, caixa_y, caixa_x+caixa_w, caixa_y+caixa_h, true);

    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_text_ext(caixa_x+24, caixa_y+20, texto_atual, 26, caixa_w-48);
}

// === QUIZ ===
if qz_ativo {
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(230, 237, 245));
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(0, 0, gw, 70, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(gw/2, 20, "Avaliacao Final - Pensamento Computacional");
    draw_set_halign(fa_left);

    if qz_fase == 0 {
        // Número da pergunta
        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(gw/2, 90,
            "Pergunta " + string(qz_pergunta_atual+1) + " de " + string(qz_num_perguntas));

        // Caixa da pergunta
        draw_set_color(c_white);
        draw_rectangle(140, 130, gw-140, 280, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(140, 130, gw-140, 280, true);
        draw_set_color(make_color_rgb(20,30,60));
        draw_set_halign(fa_left);
        draw_text_ext(160, 150, qz_perguntas[qz_pergunta_atual], 26, gw-320);

        // Alternativas
        var lista_opcoes = qz_opcoes_todas[qz_pergunta_atual];
        var base_y = 320; var alt_op = 64; var gap = 14;
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);

        var i = 0;
        repeat (4) {
            var oy = base_y + i * (alt_op + gap);
            var ox = 140; var ow = gw - 280;

            var cor;
            if qz_resposta_revelada {
                if i == qz_correta[qz_pergunta_atual] {
                    cor = make_color_rgb(20,140,60);
                } else if i == qz_resposta_selecionada {
                    cor = make_color_rgb(180,30,30);
                } else {
                    cor = c_white;
                }
            } else {
                var hover = point_in_rectangle(mx, my, ox, oy, ox+ow, oy+alt_op);
                cor = hover ? make_color_rgb(210,225,255) : c_white;
            }

            draw_set_color(cor);
            draw_rectangle(ox, oy, ox+ow, oy+alt_op, false);
            draw_set_color(make_color_rgb(140,170,210));
            draw_rectangle(ox, oy, ox+ow, oy+alt_op, true);

            var cor_texto = make_color_rgb(20,30,60);
            if qz_resposta_revelada {
                if i == qz_correta[qz_pergunta_atual] || i == qz_resposta_selecionada {
                    cor_texto = c_white;
                }
            }
            draw_set_color(cor_texto);
            draw_set_font(fnt_normal);
            draw_text_ext(ox+16, oy+14, lista_opcoes[i], 24, ow-32);
            i++;
        }

        // Feedback e botão continuar
        if qz_resposta_revelada {
            var acertou = (qz_resposta_selecionada == qz_correta[qz_pergunta_atual]);
            draw_set_color(acertou ? make_color_rgb(20,120,50) : make_color_rgb(150,30,30));
            draw_set_font(fnt_subtitulo);
            draw_set_halign(fa_left);
            draw_text(140, 612, acertou ? "Correto!" : "Nao foi dessa vez.");

            draw_set_color(make_color_rgb(20,30,60));
            draw_set_font(fnt_normal);
            draw_text_ext(140, 644, qz_explicacao[qz_pergunta_atual], 22, gw-360);

            var bx = gw-260; var by = 612; var bw = 160; var bh = 42;
            var hover2 = point_in_rectangle(mx, my, bx, by, bx+bw, by+bh);
            draw_set_color(hover2 ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
            draw_rectangle(bx, by, bx+bw, by+bh, false);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_text(bx+bw/2, by+10, "Continuar [E]");
            draw_set_halign(fa_left);
        }
    }

    else if qz_fase == 1 {
        var aprovada = (qz_acertos >= 3);

        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(140, 140, gw-140, 600, false);
        draw_set_color(c_white);
        draw_rectangle(144, 144, gw-144, 596, false);

        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(gw/2, 170,
            "Resultado: " + string(qz_acertos) + " / " + string(qz_num_perguntas));

        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(180, 230,
            aprovada ? qz_texto_aprovacao : qz_texto_revisao, 26, gw-360);

        var mx2 = display_mouse_get_x(); var my2 = display_mouse_get_y();
        var bx2 = gw/2-150; var by2 = 540; var bw2 = 300; var bh2 = 46;
        var hover3 = point_in_rectangle(mx2, my2, bx2, by2, bx2+bw2, by2+bh2);
        draw_set_color(hover3 ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
        draw_rectangle(bx2, by2, bx2+bw2, by2+bh2, false);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(bx2+bw2/2, by2+12,
            aprovada ? "Receber Recompensa [E]" : "Revisar e Continuar [E]");
        draw_set_halign(fa_left);
    }

    else if qz_fase == 2 {
        draw_set_alpha(0.75);
        draw_set_color(c_black);
        draw_rectangle(0, 0, gw, gh, false);
        draw_set_alpha(1);

        var px = gw/2-400; var py = 140; var pw = 800; var ph = 460;
        draw_set_color(c_white);
        draw_rectangle(px, py, px+pw, py+ph, false);
        draw_set_color(make_color_rgb(20,60,120));
        draw_rectangle(px, py, px+pw, py+ph, true);

        if sprite_exists(spr_tablet_recompensa) {
            draw_sprite_stretched(spr_tablet_recompensa, 0,
                px+pw/2-90, py+30, 180, 180);
        }

        draw_set_color(make_color_rgb(20,60,120));
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(px+pw/2, py+220, "Voce recebeu: TABLET");

        draw_set_color(make_color_rgb(20,30,60));
        draw_set_font(fnt_normal);
        draw_text_ext(px+40, py+260,
            "Use o tablet para consultar seus objetivos, mensagens e inventario.\n\nAgora voce ja tem uma base para organizar seu pensamento.\nO proximo passo sera aplicar isso em situacoes reais do cuidado.\n- Professora Coordenadora",
            24, pw-80);

        draw_set_color(make_color_rgb(100,130,180));
        draw_set_halign(fa_center);
        draw_text(px+pw/2, py+ph-30, "[E] Ir para a Casa do Idoso");
        draw_set_halign(fa_left);
    }
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);