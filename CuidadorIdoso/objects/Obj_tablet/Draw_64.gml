var _guil = display_get_gui_width();
var _guia = display_get_gui_height();

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if tablet == true {
	var _invx = _guil/2 - tablet_l/2;
	var _invy = _guia/2 - tablet_a/2;
	
	draw_sprite_ext(Spr_inventario, 0, _invx, _invy, escala, escala, 0, c_white, 1);
	
	var ix = 0;
	var iy = 0;
	for (var i = 0; i < total_slots; i++){
		var _slotsx = _invx + comecox + ((tamanho_do_slots + buffer) * ix);
		var _slotsy = _invy + comecoy + (tamanho_do_slots + buffer * iy);
		
		if point_in_rectangle(_mx, _my, _slotsx, _slotsy, _slotsx + tamanho_do_slots, _slotsy + tamanho_do_slots){
			draw_sprite_ext(Spr_seletor, 0, _slotsx, _slotsy, escala, escala, 0, c_white, 1);
		}
		
		ix++;
		if ix >= slots_h{
			ix=0;
			iy++;
		}
		
	}
	
}