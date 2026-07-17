// Configurações básicas de desenho
draw_set_font(fmenu_inicial); // Use a mesma fonte do seu menu
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white); // Cor do texto (mude se preferir)

// Cálculos matemáticos para separar minutos de segundos
var _minutos = floor(tempo_restante / 60);
var _segundos = floor(tempo_restante mod 60);

// Formata para garantir que sempre mostre dois dígitos (ex: "05" em vez de "5")
var _str_minutos = string_format(_minutos, 2, 0);
var _str_segundos = string_format(_segundos, 2, 0);

// Remove espaços vazios que a função "string_format" gera e substitui por "0"
_str_minutos = string_replace_all(_str_minutos, " ", "0");
_str_segundos = string_replace_all(_str_segundos, " ", "0");

// Junta tudo em uma única linha de texto
var _texto_cronometro = _str_minutos + ":" + _str_segundos;

// Desenha o cronômetro centralizado no topo da tela (posição Y = 50)
var _wgui = display_get_gui_width();
draw_text(_wgui / 2, 50, _texto_cronometro);

// Sempre reseta o alinhamento para não bugar outros textos do jogo
draw_set_halign(-1);
draw_set_valign(-1);