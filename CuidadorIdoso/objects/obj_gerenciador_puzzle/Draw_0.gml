// Desenhar as 3 caixas receptoras
for (var i = 1; i <= 3; i++) {
    // Desenha o sprite da caixa (subimage i-1)
    draw_sprite(spr_caixa, i - 1, caixa_x[i], caixa_y[i]);
    
    // Texto acima de cada caixa
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(caixa_x[i], caixa_y[i] - 80, caixa_nome[i]);
}

// Interface de Vitória (Feedback do Professor e Conceito de Computação Plugada)
if (estado == "vitoria") {
    // Fundo semi-transparente para o painel
    draw_set_alpha(0.9);
    draw_set_color(c_white);
    draw_rectangle(100, 150, 920, 550, false);
    draw_set_alpha(1.0);
    draw_set_color(c_black);
    draw_rectangle(100, 150, 920, 550, true);
    
    // Desenha a fala do Professor
    draw_set_halign(fa_left);
    draw_text_ext(150, 180, "NPC Professor:\n" + texto_professor, 20, 700);
    
    // Linha divisória
    draw_line(150, 360, 870, 360);
    
    // Desenha a Frase de Aprendizagem em destaque
    draw_set_color(c_darkvideo); // Cor de destaque para o conceito
    draw_text_ext(150, 390, "Pensamento Computacional:\n" + texto_aprendizagem, 20, 700);
}