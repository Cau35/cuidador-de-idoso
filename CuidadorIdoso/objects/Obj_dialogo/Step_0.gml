if (inicializar == false) {
    scr_textos();
    inicializar = true;
}
if (mouse_check_button_pressed(mb_left)) {
    if pagina < ds_grid_height(texto_grid) - 1 {
        pagina++;
    } else {
		global.dialogo = false;
        instance_destroy();
    }
}