var _gui_l = display_get_gui_width();
var _gui_a = display_get_gui_height();

var _xx = 0;
var _yy = _gui_a - 200;
var _c = c_black;

draw_rectangle_color(_xx, _yy, _gui_l, _gui_a, _c, _c, _c, _c, false);

draw_set_font(fnt_dialogo);
draw_text_ext(_xx + 32, _yy + 32, texto[pagina], 32, _gui_l - 64);