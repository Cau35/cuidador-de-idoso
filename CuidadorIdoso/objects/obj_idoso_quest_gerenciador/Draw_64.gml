if !quest_ativa exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = display_mouse_get_x();
var my = display_mouse_get_y();
var num = obter_num_itens();

// Fundo do overlay
draw_set_alpha(0.96);
draw_set_color(make_color_rgb(235, 240, 250));
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// =========================================
// CABECALHO
// =========================================
draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(0, 0, gw, 70, false);
draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);

var titulos_mq = ["Higiene e Conforto", "Sinais de Alerta", "Alimentacao e Hidratacao"];
draw_text(gw/2, 10, "Quest do Idoso - " + titulos_mq[mini_quest_atual]);

// Indicador de progresso das mini-quests
draw_set_font(fnt_normal);
var prog = "";
var pm = 0;
repeat (3) {
    prog += mini_completa[pm] ? "[v] " : (pm == mini_quest_atual ? "[>] " : "[ ] ");
    pm++;
}
draw_text(gw/2, 44, prog);
draw_set_halign(fa_left);

// =========================================
// 3 CATEGORIAS (painel superior)
// =========================================
var cat_gap = (gw - 3*cat_w) / 4;
var cat_y   = 80;

var c = 0;
repeat (3) {
    var cat_x = cat_gap + c * (cat_w + cat_gap);

    // Cor da categoria
    var cor_cat = make_color_rgb(200, 215, 240);
    var cor_borda = make_color_rgb(100, 140, 200);

    // Verifica se algum item correto esta nessa cat
    var tem_correto = false;
    var tem_errado  = false;
    var b_check = 0;
    repeat (num) {
        if item_no_cat[b_check] == c {
            if obter_cat_correta_item(b_check) == c {
                tem_correto = true;
            } else {
                tem_errado = true;
            }
        }
        b_check++;
    }

    if tem_correto && !tem_errado {
        cor_cat   = make_color_rgb(200, 240, 210);
        cor_borda = make_color_rgb(40, 160, 80);
    } else if tem_errado {
        cor_cat   = make_color_rgb(240, 210, 210);
        cor_borda = make_color_rgb(200, 60, 60);
    }

    // Hover da categoria
    var hover_cat = point_in_rectangle(mx, my, cat_x, cat_y, cat_x+cat_w, cat_y+cat_h)
                 && item_arrastando != -1;
    if hover_cat {
        cor_cat   = make_color_rgb(220, 235, 255);
        cor_borda = make_color_rgb(60, 120, 220);
    }

    draw_set_color(cor_cat);
    draw_rectangle(cat_x, cat_y, cat_x+cat_w, cat_y+cat_h, false);
    draw_set_color(cor_borda);
    draw_rectangle(cat_x, cat_y, cat_x+cat_w, cat_y+cat_h, true);

    // Nome da categoria
    draw_set_color(make_color_rgb(20, 60, 120));
    draw_rectangle(cat_x, cat_y, cat_x+cat_w, cat_y+32, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_set_halign(fa_center);
    draw_text(cat_x+cat_w/2, cat_y+8, obter_nome_cat(c));
    draw_set_halign(fa_left);

    // Itens dentro da categoria
    var pos_dentro = 0;
    var b2 = 0;
    repeat (num) {
        if item_no_cat[b2] == c && item_arrastando != b2 {
            var ix = cat_x + 10 + (pos_dentro mod 2) * (item_w + 8);
            var iy = cat_y + 36 + floor(pos_dentro / 2) * (item_h + 8);

            var spr = obter_sprite_item(b2);
            var esta_certo = (obter_cat_correta_item(b2) == c);

            // Fundo do item
            draw_set_color(esta_certo
                ? make_color_rgb(180, 235, 190)
                : make_color_rgb(235, 180, 180));
            draw_rectangle(ix, iy, ix+item_w, iy+item_h, false);
            draw_set_color(esta_certo
                ? make_color_rgb(40, 160, 80)
                : make_color_rgb(200, 60, 60));
            draw_rectangle(ix, iy, ix+item_w, iy+item_h, true);

            // Sprite do item
            if sprite_exists(spr) {
                draw_sprite_stretched(spr, 0, ix+8, iy+8, item_w-16, item_h-32);
            }

            // Nome
            draw_set_color(make_color_rgb(20, 30, 60));
            draw_set_font(fnt_normal);
            draw_set_halign(fa_center);
            draw_text(ix+item_w/2, iy+item_h-18, obter_nome_item(b2));
            draw_set_halign(fa_left);

            // Icone correto/errado
            draw_set_font(fnt_subtitulo);
            draw_set_halign(fa_right);
            draw_set_color(esta_certo
                ? make_color_rgb(20, 140, 60)
                : make_color_rgb(200, 50, 50));
            draw_text(ix+item_w-4, iy+4, esta_certo ? "V" : "X");
            draw_set_halign(fa_left);

            pos_dentro++;
        }
        b2++;
    }

    c++;
}

// =========================================
// ITENS NO PAINEL INFERIOR (ainda nao arrastados)
// =========================================
var b = 0;
repeat (num) {
    var esta_correto = (item_no_cat[b] != -1)
                    && (obter_cat_correta_item(b) == item_no_cat[b]);
    var sendo_arrastado = (item_arrastando == b);

    // Nao desenha no painel se esta numa categoria (exceto se arrastando)
    if item_no_cat[b] == -1 || sendo_arrastado {
        var bx = 0;
        var by = 0;

        if sendo_arrastado {
            bx = mx - item_offset_x;
            by = my - item_offset_y;
        } else {
            var pos = obter_pos_item_orig(b);
            bx = pos.x;
            by = pos.y;
        }

        var hover_item = point_in_rectangle(mx, my, bx, by, bx+item_w, by+item_h)
                      && item_arrastando == -1;

        // Fundo do item
        draw_set_alpha(sendo_arrastado ? 0.85 : 1);
        draw_set_color(hover_item
            ? make_color_rgb(200, 220, 255)
            : make_color_rgb(230, 235, 250));
        draw_rectangle(bx, by, bx+item_w, by+item_h, false);
        draw_set_color(hover_item
            ? make_color_rgb(60, 120, 220)
            : make_color_rgb(140, 160, 210));
        draw_rectangle(bx, by, bx+item_w, by+item_h, true);

        // Sprite do item
        var spr = obter_sprite_item(b);
        if sprite_exists(spr) {
            draw_sprite_stretched(spr, 0, bx+8, by+8, item_w-16, item_h-32);
        } else {
            // Fallback: letra inicial
            draw_set_color(make_color_rgb(80, 100, 160));
            draw_set_font(fnt_titulo);
            draw_set_halign(fa_center);
            draw_text(bx+item_w/2, by+item_h/2-20,
                string_upper(string_copy(obter_nome_item(b), 1, 1)));
        }

        // Nome do item
        draw_set_color(make_color_rgb(20, 30, 60));
        draw_set_font(fnt_normal);
        draw_set_halign(fa_center);
        draw_text(bx+item_w/2, by+item_h-18, obter_nome_item(b));
        draw_set_halign(fa_left);
        draw_set_alpha(1);
    }

    b++;
}

// =========================================
// FEEDBACK / TUTOR (fase 1 e 2)
// =========================================
if fase == 1 {
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(20, 100, 45));
    draw_rectangle(gw/2-360, 260, gw/2+360, 420, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(gw/2, 278, "Muito bem! Todos os itens no lugar certo!");

    var bx2 = gw/2-180; var by2 = 358; var bw2 = 360; var bh2 = 44;
    var hover2 = point_in_rectangle(mx, my, bx2, by2, bx2+bw2, by2+bh2);
    draw_set_color(hover2 ? make_color_rgb(20,80,170) : make_color_rgb(30,100,200));
    draw_rectangle(bx2, by2, bx2+bw2, by2+bh2, false);
    draw_set_color(c_white);
    draw_set_font(fnt_normal);
    draw_text(gw/2, by2+11, "Ver explicacao [E]");
    draw_set_halign(fa_left);
}

if fase == 2 {
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    var tpx = 80; var tpy = 80;
    var tpw = gw-160; var tph = gh-160;

    draw_set_color(c_white);
    draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, false);
    draw_set_color(make_color_rgb(20,60,120));
    draw_rectangle(tpx, tpy, tpx+tpw, tpy+tph, true);
    draw_rectangle(tpx, tpy, tpx+tpw, tpy+48, false);

    draw_set_color(c_white);
    draw_set_font(fnt_titulo);
    draw_set_halign(fa_center);
    draw_text(tpx+tpw/2, tpy+10, titulos_mq[mini_quest_atual]);

    draw_set_color(make_color_rgb(20,30,60));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_left);
    draw_text_ext(tpx+24, tpy+62, tutor_texto[mini_quest_atual], 28, tpw-48);

    // Botao continuar / proximo
    var label_btn = mini_quest_atual < 2 ? "Proxima Mini-Quest [E]" : "Concluir Quest [E]";
    draw_set_color(make_color_rgb(100,130,180));
    draw_set_font(fnt_normal);
    draw_set_halign(fa_right);
    draw_text(tpx+tpw-16, tpy+tph-20, label_btn);
    draw_set_halign(fa_left);
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_alpha(1);