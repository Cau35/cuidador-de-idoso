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

if (mouse_check_button_pressed(mb_left)) {
    if (caractere < string_length(texto[pagina])) {
        caractere = string_length(texto[pagina]);
    } 

    else {
        if (pagina < array_length(texto) - 1) {
            pagina++;
            caractere = 0;
            alarm[0] = 1;
        } else {
            global.dialogo = false;
            instance_destroy();
        }
    }
}
// Navegar nas opções (W aumenta, S diminui) [00:20:50]
op_selecionada += keyboard_check_pressed(ord("W")) - keyboard_check_pressed(ord("S"));
op_selecionada = clamp(op_selecionada, 0, op_num - 1); // Garante que não sai do limite [00:22:53]

// Confirmar escolha [00:23:31]
if (keyboard_check_pressed(ord("F"))) {
    var _target = op_resposta[op_selecionada];
    instance_create_layer(x, y, "Instances", obj_dialogo, { npc_nome: _target });
    instance_destroy();
}