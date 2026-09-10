var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Fundo escuro semi-transparente cobrindo a tela
draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(40, 40, _w - 40, _h - 40, false);

// Configuração do texto
draw_set_alpha(1.0);
draw_set_color(c_white);

var _tx = 70;
var _ty = 70;

// Conteúdo exibido na Room
draw_text(_tx, _ty, "=== AVISO DE LICENÇA E DIREITOS AUTORAIS ===");
_ty += 35;
draw_text(_tx, _ty, "Autor Original: " + GAME_AUTHOR);
_ty += 25;
draw_text(_tx, _ty, "E-mail: " + GAME_EMAIL_PART + " / " + GAME_EMAIL_INST);
_ty += 25;
draw_text(_tx, _ty, "ORCID: " + GAME_ORCID);
_ty += 25;
draw_text(_tx, _ty, "Telefone: " + GAME_PHONE);
_ty += 40;

draw_set_color(c_yellow);
draw_text(_tx, _ty, "ESTE SOFTWARE E SEUS CÓDIGOS/RECURSOS SÃO DE USO EXCLUSIVAMENTE GRATUITO.");
_ty += 25;
draw_text(_tx, _ty, "PROIBIDA A COMERCIALIZAÇÃO OU O USO EM PRODUTOS PAGOS.");
_ty += 35;

draw_set_color(c_silver);
draw_text(_tx, _ty, "Pressione qualquer tecla ou clique para continuar...");