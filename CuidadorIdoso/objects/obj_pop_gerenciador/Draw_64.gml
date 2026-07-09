// Protecao: sai se o objeto nao foi inicializado ainda
if !variable_instance_exists(id, "fase") exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Dimensoes dos slots (painel direito)
var sx     = 760;
var sy_ini = 128;
var sw     = gw - sx - 44;
var sh     = 88;
var sgap   = 10;

// -------------------------------------------------------
// OVERLAY ESCURO DOS PAINEIS
// -------------------------------------------------------
draw_set_alpha(0.78);
draw_set_color(c_black);
draw_rectangle(40, 80, 720, gh - 60, false);
draw_rectangle(sx - 20, 80, gw - 40, gh - 60, false);
draw_set_alpha(1);

// -------------------------------------------------------
// CABECALHOS
// -------------------------------------------------------
draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(40, 80, 720, 118, false);
draw_rectangle(sx - 20, 80, gw - 40, 118, false);

draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);
draw_text(380, 90, "Blocos do Procedimento");
draw_text(sx + sw / 2, 90, "Linha do Tempo");
draw_set_halign(fa_left);

// -------------------------------------------------------
// SLOTS (painel direito)
// -------------------------------------------------------
var s = 0;
repeat (5) {
    var sy = sy_ini + s * (sh + sgap);

    // Qual bloco esta nesse slot?
    var bloco_aqui = -1;
    var b = 0;
    repeat (5) {
        if bloco_no_slot[b] == s {
            bloco_aqui = b;
        }
        b++;
    }

    // Cor do slot
    var cor_slot = make_color_rgb(40, 55, 90); // vazio
    if bloco_aqui != -1 {
        if slot_correto[s] {
            cor_slot = make_color_rgb(20, 100, 45);
        } else {
            cor_slot = make_color_rgb(140, 25, 25);
        }
    }

    draw_set_alpha(0.9);
    draw_set_color(cor_slot);
    draw_rectangle(sx, sy, sx + sw, sy + sh, false);
    draw_set_alpha(1);

    // Borda
    var cor_borda = make_color_rgb(100, 140, 200);
    if slot_correto[s] { cor_borda = make_color_rgb(60, 200, 100); }
    if slot_errado[s]  { cor_borda = make_color_rgb(220, 60, 60);  }
    draw_set_color(cor_borda);
    draw_rectangle(sx, sy, sx + sw, sy + sh, true);

    // Badge numero
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(sx, sy, sx + 38, sy + sh, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(sx + 19, sy + sh / 2 - 12, string(s + 1));
    draw_set_halign(fa_left);

    // Rotulo do passo
    draw_set_color(make_color_rgb(180, 210, 255));
    draw_set_font(fnt_normal);
    draw_text(sx + 48, sy + 8, passo_rotulo[s]);

    // Conteudo
    if bloco_aqui == -1 {
        draw_set_color(make_color_rgb(100, 130, 180));
        draw_text(sx + 48, sy + 34, "Arraste o bloco correto aqui");
    } else {
        draw_set_color(c_white);
        draw_text_ext(sx + 48, sy + 28, textos_blocos[bloco_aqui], 20, sw - 60);
    }

    // Icone correto
    if slot_correto[s] {
        draw_set_color(make_color_rgb(80, 220, 120));
        draw_set_font(fnt_subtitulo);
        draw_set_halign(fa_right);
        draw_text(sx + sw - 10, sy + sh / 2 - 10, "V");
        draw_set_halign(fa_left);
    }

    // Dica se errado e slot vazio
    if slot_errado[s] && bloco_aqui == -1 {
        draw_set_color(make_color_rgb(255, 200, 100));
        draw_set_font(fnt_normal);
        draw_text_ext(sx + 48, sy + 52, dica_slot[s], 16, sw - 60);
    }

    s++;
}

// -------------------------------------------------------
// BLOCOS (painel esquerdo)
// -------------------------------------------------------
var b = 0;
repeat (5) {
    // Nao desenha bloco em slot correto (a menos que esteja sendo arrastado)
    var em_slot_correto = (bloco_no_slot[b] != -1) && slot_correto[bloco_no_slot[b]];
    var sendo_arrastado = (bloco_arrastando == b);

    if !em_slot_correto || sendo_arrastado {

        // Posicao do bloco
        var bx = 0;
        var by = 0;

        if sendo_arrastado {
            bx = mx - bloco_offset_x;
            by = my - bloco_offset_y;
        } else if bloco_no_slot[b] != -1 {
            // Bloco em slot errado: aparece dentro do slot
            var s_atual = bloco_no_slot[b];
            bx = sx + 2;
            by = sy_ini + s_atual * (sh + sgap) + 2;
        } else {
            bx = bloco_orig_x[b];
            by = bloco_orig_y[b];
        }

        // Hover so no painel esquerdo quando nao esta arrastando
        var hover_bloco = false;
        if bloco_arrastando == -1 && bloco_no_slot[b] == -1 {
            hover_bloco = point_in_rectangle(mx, my, bx, by, bx + bloco_w, by + bloco_h);
        }

        // Cor
        var cor_bloco = make_color_rgb(50, 70, 120);
        if sendo_arrastado  { cor_bloco = make_color_rgb(90, 130, 210); }
        if hover_bloco      { cor_bloco = make_color_rgb(70, 100, 170); }

        var alpha_bloco = 1;
        if sendo_arrastado { alpha_bloco = 0.88; }

        draw_set_alpha(alpha_bloco);
        draw_set_color(cor_bloco);
        draw_rectangle(bx, by, bx + bloco_w, by + bloco_h, false);
        draw_set_color(make_color_rgb(100, 140, 200));
        draw_rectangle(bx, by, bx + bloco_w, by + bloco_h, true);

        // Badge letra
        draw_set_color(make_color_rgb(20, 60, 120));
        draw_rectangle(bx, by, bx + 40, by + bloco_h, false);
        draw_set_color(c_white);
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_center);
        draw_text(bx + 20, by + bloco_h / 2 - 12, chr(ord("A") + b));

        // Texto
        draw_set_color(c_white);
        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_text_ext(bx + 52, by + 12, textos_blocos[b], 24, bloco_w - 64);

        draw_set_alpha(1);
    }

    b++;
}

// -------------------------------------------------------
// BARRA DE PROGRESSO
// -------------------------------------------------------
draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(40, gh - 56, gw - 40, gh - 16, false);
draw_set_color(c_white);
draw_set_font(fnt_subtitulo);
draw_set_halign(fa_center);
var total_certos = 0;
var sc = 0;
repeat (5) {
    if slot_correto[sc] { total_certos++; }
    sc++;
}
draw_text(gw / 2, gh - 46, "Passos corretos: " + string(total_certos) + " / 5");
draw_set_halign(fa_left);

// -------------------------------------------------------
// PAINEL DE CONCLUSAO (fase 1)
// -------------------------------------------------------
if fase == 1 {
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(20, 100, 45));
    draw_rectangle(160, 260, 1120, 420, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(gw / 2, 278, "Protocolo executado com sucesso!");
    draw_set_font(fnt_normal);
    draw_text(gw / 2, 320, "Dona Silvia foi transferida com seguranca.");

    var bx2 = gw / 2 - 180;
    var by2 = 360;
    var bw2 = 360;
    var bh2 = 44;
    var hover2 = point_in_rectangle(mx, my, bx2, by2, bx2 + bw2, by2 + bh2);
    draw_set_color(hover2 ? make_color_rgb(20, 80, 170) : make_color_rgb(30, 100, 200));
    draw_rectangle(bx2, by2, bx2 + bw2, by2 + bh2, false);
    draw_set_color(c_white);
    draw_text(gw / 2, by2 + 11, "Ver analise do professor [E]");
    draw_set_halign(fa_left);
}

// -------------------------------------------------------
// TUTOR (fase 2)
// -------------------------------------------------------
if fase == 2 {
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    var tpx = 80;
    var tpy = 70;
    var tpw = gw - 160;
    var tph = gh - 140;

    draw_set_color(c_white);
    draw_rectangle(tpx, tpy, tpx + tpw, tpy + tph, false);
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(tpx, tpy, tpx + tpw, tpy + tph, true);
    draw_rectangle(tpx, tpy, tpx + tpw, tpy + 48, false);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(tpx + tpw / 2, tpy + 10, "Analise do Professor - Criacao de Algoritmos");

    draw_set_color(make_color_rgb(20, 30, 60));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
    draw_text_ext(tpx + 24, tpy + 62, texto_tutor, 28, tpw - 48);

    draw_set_color(make_color_rgb(100, 130, 180));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_right);
    draw_text(tpx + tpw - 16, tpy + tph - 20, "[E] Concluir Quest");
    draw_set_halign(fa_left);
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);