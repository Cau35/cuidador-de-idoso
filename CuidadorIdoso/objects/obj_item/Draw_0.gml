// Desenha a si mesmo usando o frame correto definido no Manager
draw_sprite(spr_itens, subimage, x, y);

// Feedback visual simples se estiver na caixa correta (ex: uma borda verde sutil)
if (encaixado && caixa_atual == caixa_correta) {
    draw_set_color(c_lime);
    draw_circle(x, y, 24, true);
}