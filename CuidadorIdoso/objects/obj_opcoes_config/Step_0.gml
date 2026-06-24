
var mouse_sobre_opcao = -1;

for (var i = 0; i < total_opcoes; i++) {
    var yy = menu_y + (i * espacamento);
    var largura_texto = 200;
    var altura_texto = 30;
    
    if (point_in_rectangle(mouse_x, mouse_y, 
        menu_x - largura_texto, yy - altura_texto/2,
        menu_x + largura_texto, yy + altura_texto/2)) {
        mouse_sobre_opcao = i;
        opcao_selecionada = i;
    }
}


if (mouse_check_button_pressed(mb_left) && mouse_sobre_opcao >= 0) {
    switch (mouse_sobre_opcao) {
        case 1: 
            tela_cheia = !tela_cheia;
            window_set_fullscreen(tela_cheia);
            break;
        case 2: 
            room_goto(room_anterior);
            break;
    }
}


if (opcao_selecionada == 0 && mouse_check_button(mb_left)) {
    var barra_x = menu_x - 100;
    var barra_largura = 200;
    
    if (mouse_x >= barra_x && mouse_x <= barra_x + barra_largura) {
        volume_global = clamp((mouse_x - barra_x) / barra_largura, 0, 1);
        audio_master_gain(volume_global);
    }
}

if (keyboard_check_pressed(vk_up)) {
    opcao_selecionada--;
    if (opcao_selecionada < 0) opcao_selecionada = total_opcoes - 1;
    audio_play_sound(snd_citysound, 1, false); // Som opc
}

if (keyboard_check_pressed(vk_down)) {
    opcao_selecionada++;
    if (opcao_selecionada >= total_opcoes) opcao_selecionada = 0;
    
}


if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    switch (opcao_selecionada) {
        case 2: // Voltar
            room_goto(room_anterior);
            break;
    }
}


if (opcao_selecionada == 0) {
    if (keyboard_check(vk_left)) {
        volume_global = max(0, volume_global - 0.01);
        audio_master_gain(volume_global);
    }
    if (keyboard_check(vk_right)) {
        volume_global = min(1, volume_global + 0.01);
        audio_master_gain(volume_global);
    }
}


if (opcao_selecionada == 1) {
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) 
        || keyboard_check_pressed(vk_enter)) {
        tela_cheia = !tela_cheia;
        window_set_fullscreen(tela_cheia);
    }
}
