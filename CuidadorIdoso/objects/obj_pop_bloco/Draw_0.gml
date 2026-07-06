var ger = gerenciador;

var cor;

if (fixado)
{
    cor = cor_correto;
}
else if (arrastando)
{
    cor = cor_arrasto;
}
else if (point_in_rectangle(mouse_x, mouse_y, x, y, x + largura, y + altura))
{
    cor = cor_hover;
}
else
{
    if (no_slot >= 0 && ger.slot_errado[no_slot])
    {
        cor = cor_errado;
    }
    else
    {
        cor = cor_normal;
    }
}

// Fundo
draw_set_alpha(arrastando ? 0.88 : 1);
draw_set_color(cor);
draw_rectangle(x, y, x + largura, y + altura, false);


draw_set_color(
    arrastando
    ? make_color_rgb(150, 190, 255)
    : make_color_rgb(100, 140, 200)
);
draw_rectangle(x, y, x + largura, y + altura, true);


draw_set_color(make_color_rgb(20, 60, 120));
draw_rectangle(x, y, x + 40, y + altura, false);

// Letra
draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);
draw_text(x + 20, y + altura / 2 - 12, chr(ord("A") + indice));

// Texto
draw_set_color(c_white);
draw_set_font(fnt_normal);
draw_set_halign(fa_left);
draw_text_ext(x + 52, y + 12, texto_bloco, 24, largura - 64);
draw_set_alpha(1);
draw_set_font(-1);
draw_set_halign(fa_left);