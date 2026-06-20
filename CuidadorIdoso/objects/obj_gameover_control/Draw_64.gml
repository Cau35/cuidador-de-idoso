// --- Documentação ---
// display_get_gui_width/height: Obtém o tamanho da janela do jogo.
// draw_set_alpha: Define a transparência (0 é invisível, 1 é sólido).
// draw_set_halign: Alinha o texto horizontalmente (fa_center = centro).

// 1. Desenhar o fundo vermelho semitransparente (estilo Minecraft)
draw_set_color(c_black);
draw_set_alpha(0.5); // 50% de transparência
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

draw_set_color(c_red);
draw_set_alpha(0.2); // Um leve tom vermelho por cima
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// 2. Desenhar o texto "Foste morto!" ou "You died!"
draw_set_alpha(1.0); // Resetar a transparência para o texto ficar sólido
draw_set_color(c_white);
draw_set_halign(fa_center); // Centralizar o texto

// Desenha o texto no centro da tela (ajusta o valor 200 conforme precises)
draw_text_transformed(display_get_gui_width() / 2, 200, "Game Over!", 3, 3, 0);

// 3. (Opcional) Desenhar a pontuação
draw_text(display_get_gui_width() / 2, 300, "Tente novamente.");