var s = global.cutscene_bg;
if (s != noone) {
	var w = display_get_gui_width();
	var h = display_get_gui_height();
	draw_sprite_stretched(s, 0, 0, 0, w, h);
}