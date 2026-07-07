// --- Desenho do Botão na Interface (GUI) ---

// 1. Definir a cor do botão (Cinza escuro estilo Minecraft)
draw_set_color(c_dkgray);
// Desenha o retângulo (ajustando para ficar centrado)
draw_rectangle(x_gui - largura/2, y_gui - altura/2, x_gui + largura/2, y_gui + altura/2, false);

// 2. Desenhar a borda do botão
draw_set_color(c_white);
draw_rectangle(x_gui - largura/2, y_gui - altura/2, x_gui + largura/2, y_gui + altura/2, true);

// 3. Desenhar o texto centralizado
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x_gui, y_gui, texto);