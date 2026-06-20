
draw_self(); // Desenha o sprite do cartão

draw_set_font(-1); // Use sua fonte aqui se tiver uma
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha o texto que definimos no Manager dentro do cartão
draw_text_ext(x, y, texto, 15, sprite_width - 10); 

draw_set_color(c_white); // Reseta a cor para o resto do jogo
