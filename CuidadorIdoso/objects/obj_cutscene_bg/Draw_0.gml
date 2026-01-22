if (!variable_global_exists("cutscene_bg")) {
    global.cutscene_bg = noone;
}

if (global.cutscene_bg != noone) {

    var sw = sprite_get_width(global.cutscene_bg);
    var sh = sprite_get_height(global.cutscene_bg);

    var gw = display_get_width();
    var gh = display_get_height();

    var sx = gw / sw;
    var sy = gh / sh;

    draw_sprite_ext(global.cutscene_bg, 0, 0, 0, sx, sy, 0, c_white, 1);
}