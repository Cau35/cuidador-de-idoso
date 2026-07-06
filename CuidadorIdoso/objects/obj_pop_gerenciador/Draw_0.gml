// Fundo
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

if (sprite_exists(spr_quarto))
{
    draw_sprite_stretched(spr_quarto, 0, 0, 0, room_width, room_height);
}

// Painéis
draw_set_alpha(0.72);
draw_set_color(c_black);
draw_rectangle(40, 80, 720, 700, false);
draw_rectangle(760, 80, 1240, 700, false);
draw_set_alpha(1);


draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(40, 80, 720, 118, false);

draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);
draw_text(380, 88, "Blocos do Procedimento");

// Título direito
draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(760, 80, 1240, 118, false);

draw_set_color(c_white);
draw_text(1000, 88, "Linha do Tempo");
draw_set_halign(fa_left);

// Slots
for (var s = 0; s < 5; s++)
{
    var sx = slot_x;
    var sy = slot_y_inicio + s * (slot_altura + slot_gap);

    // Cor do slot
    var cor_slot;

    if (slot_conteudo[s] == -1)
    {
        cor_slot = make_color_rgb(40, 55, 90);
    }
    else if (slot_correto[s])
    {
        cor_slot = make_color_rgb(20, 100, 45);
    }
    else if (slot_errado[s])
    {
        cor_slot = make_color_rgb(140, 25, 25);
    }
    else
    {
        cor_slot = make_color_rgb(40, 55, 90);
    }

    // Fundo
    draw_set_alpha(0.9);
    draw_set_color(cor_slot);
    draw_rectangle(sx, sy, sx + slot_largura, sy + slot_altura, false);
    draw_set_alpha(1);

    // Borda
    var cor_borda;

    if (slot_correto[s])
        cor_borda = make_color_rgb(60, 200, 100);
    else if (slot_errado[s])
        cor_borda = make_color_rgb(220, 60, 60);
    else
        cor_borda = make_color_rgb(100, 140, 200);

    draw_set_color(cor_borda);
    draw_rectangle(sx, sy, sx + slot_largura, sy + slot_altura, true);

    
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(sx, sy, sx + 38, sy + slot_altura, false);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(sx + 19, sy + slot_altura / 2 - 12, string(s + 1));

    
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(180, 210, 255));
    draw_text(sx + 48, sy + 8, passo_rotulo[s]);

    // Conteúdo do slot
    if (slot_conteudo[s] == -1)
    {
        draw_set_color(make_color_rgb(100, 130, 180));
        draw_text(sx + 48, sy + 34, "Arraste o bloco correto aqui");
    }
    else if (slot_correto[s])
    {
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(80, 220, 120));
        draw_text(sx + slot_largura - 10, sy + slot_altura / 2 - 12, "✓");
    }
    else if (slot_errado[s])
    {
        draw_set_font(fnt_titulo);
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(255, 100, 100));
        draw_text(sx + slot_largura - 10, sy + slot_altura / 2 - 12, "✗");

        draw_set_font(fnt_normal);
        draw_set_halign(fa_left);
        draw_set_color(make_color_rgb(255, 200, 100));
        draw_text_ext(
            sx + 48,
            sy + 52,
            dica_slot[s],
            16,
            slot_largura - 60
        );
    }

    draw_set_halign(fa_left);
}

function desenhar_tutor() {
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, 1280, 720, false);
    draw_set_alpha(1);

    var px = 90; var py = 90; var pw = 1100; var ph = 520;
    draw_set_color(c_white);
    draw_rectangle(px, py, px+pw, py+ph, false);
    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(px, py, px+pw, py+ph, true);

    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(px, py, px+pw, py+48, false);
    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(px+pw/2, py+10, "Análise do Professor — Criação de Algoritmos");

    draw_set_color(make_color_rgb(20,30,60));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
    draw_text_ext(px+24, py+62, texto_tutor, 28, pw-48);

    draw_set_color(make_color_rgb(20,60,120));
    draw_set_font(fnt_titulo);
    draw_text(px+24, py+ph-72,
        "Algoritmo: sequência de passos ordenados com lógica e propósito clínico.");

    var bx = px+pw-220; var by = py+ph-46; var bw = 196; var bh = 34;
    var hover = point_in_rectangle(mouse_x, mouse_y, bx, by, bx+bw, by+bh);
    draw_set_color(hover ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
    draw_rectangle(bx, by, bx+bw, by+bh, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(bx+bw/2, by+8, "Concluir Quest ✓");
    draw_set_halign(fa_left);
}

// Contador
var total_certos = 0;

for (var i = 0; i < 5; i++)
{
    if (slot_correto[i])
        total_certos++;
}

draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(760, 660, 1240, 700, false);

draw_set_color(c_white);
draw_set_font(fnt_subtitulo);
draw_set_halign(fa_center);
draw_text(1000, 668, "Passos corretos: " + string(total_certos) + " / 5");

// Restaurar estado
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_color(c_white);