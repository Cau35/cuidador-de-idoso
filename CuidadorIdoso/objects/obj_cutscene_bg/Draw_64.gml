if (!variable_global_exists("cutscene_bg")) {
    global.cutscene_bg = noone;
}

if (global.cutscene_bg != noone) {
    draw_sprite(global.cutscene_bg, 0, 0, 0);
}