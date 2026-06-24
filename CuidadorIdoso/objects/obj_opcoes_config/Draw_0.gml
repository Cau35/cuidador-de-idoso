// Fundo semi-transparente (opcional)
draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Configurações de texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_set_font(fmenu_inicial); 
draw_text(menu_x, menu_y - 80, "OPÇÕES");

// Desenhar opções
draw_set_font(fmenu_inicial); // Crie uma fonte ou remova esta linha

var _opcoes = [
    "Volume: " + string(round(volume_global * 100)) + "%",
    "Tela: " + (tela_cheia ? "Cheia" : "Janela"),
    "Voltar"
];

for (var i = 0; i < total_opcoes; i++) {
    var yy = menu_y + (i * espacamento);
    
    // Destacar opção selecionada
    if (i == opcao_selecionada) {
        draw_set_color(c_yellow);
        draw_text(menu_x, yy, "> " + _opcoes[i] + " <");
    } else {
        draw_set_color(c_white);
        draw_text(menu_x, yy, _opcoes[i]);
    }
}

// Instruções
draw_set_color(c_gray);
draw_set_font(-1);
draw_text(menu_x, room_height - 50, "Setas: Navegar | Enter: Selecionar | ←→: Ajustar");
