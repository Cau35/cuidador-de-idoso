// === CONFIGURAÇÃO DAS CAIXAS ===
caixa_nomes[0] = "vestir/usar";
caixa_nomes[1] = "registrar o cuidado";
caixa_nomes[2] = "conferir antes de sair";


caixa_respostas[0] = ["luva", "cracha", "alcool"];
caixa_respostas[1] = ["caderno", "caneta", "ficha", "lista_de_cuidados"];
caixa_respostas[2] = ["endereco", "documento", "agua"];


quest_concluida = false;
mostrar_feedback = false;
feedback_timer = 0;
feedback_texto = "";
mostrar_fala_professor = false;

// Função: verificar quest completa
function verificar_quest_completa() {
    var total_corretos = 0;
    var total_esperados = 0;

    for (var c = 0; c < 3; c++) {
        total_esperados += array_length(caixa_respostas[c]);
    }

    with (obj_item) {
        if (self.na_caixa_correta) total_corretos++;
    }

    if (total_corretos >= total_esperados) {
        quest_concluida = true;
        mostrar_fala_professor = true;
    }
}
// Função: desenhar fala do professor
function desenhar_fala_professor() {
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var bx = 60; var by = gh - 260;
    var bw = gw - 120; var bh = 220;

    draw_set_alpha(0.95);
    draw_set_color(c_black);
    draw_rectangle(bx, by, bx + bw, by + bh, false);
    draw_set_color(c_gray);
    draw_rectangle(bx, by, bx + bw, by + bh, true);
    draw_set_alpha(1);

    draw_set_color(c_navy);
    draw_set_font(fnt_dialogo);
    draw_text(bx + 20, by + 15, "Professor:");

    draw_set_font(fnt_dialogo);
    var fala = "Percebeu? Preparar uma visita domiciliar parecia uma tarefa grande.\nMas, quando você separou em partes menores — o que vestir,\no que levar e o que conferir — ficou muito mais fácil!\n\nIsso é DECOMPOSIÇÃO.";
    draw_text_ext(bx + 30, by + 65, fala, 25, bw - 40);

    // Botão fechar
    draw_set_color(c_black);
    draw_rectangle(bx + bw - 110, by + bh - 45, bx + bw - 10, by + bh - 10, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(bx + bw - 60, by + bh - 38, "Continuar");
    draw_set_halign(fa_center);
}
