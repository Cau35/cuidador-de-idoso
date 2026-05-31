// Define qual frame mostrar baseado no tipo
image_index = tipo_caixa - 1; 

draw_self();

// Desenha o rótulo da caixa
draw_set_halign(fa_center);
draw_set_color(c_black);
var nome = "";
switch(tipo_caixa) {
    case 1: nome = "O que vestir/usar"; break;
    case 2: nome = "O que registrar"; break;
    case 3: nome = "O que conferir"; break;
}
draw_text(x, y + 110, nome); // Escreve o nome abaixo da caixa