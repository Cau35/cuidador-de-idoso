
if tablet_aberto {
    var px=140; var py=80; var pw=1000;
    var aba_w = pw/4;
    for (var i = 0; i < 4; i++) {
        var ax = px + i*aba_w;
        if point_in_rectangle(mouse_x, mouse_y, ax, py, ax+aba_w, py+44) {
            tablet_aba = i;
        }
    }
    if point_in_rectangle(mouse_x, mouse_y, px+pw-44, py+4, px+pw-8, py+40) {
        tablet_aberto = false;
    }
}