
if fase == 1 {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var gw = display_get_gui_width();
    var bx2 = gw / 2 - 180;
    var by2 = 360;
    var bw2 = 360;
    var bh2 = 44;
    if point_in_rectangle(mx, my, bx2, by2, bx2 + bw2, by2 + bh2) {
        fase = 2;
    }
}