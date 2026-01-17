// Inicialização do diálogo
if (inicializar == false) {
    scr_textos();
    inicializar = true;
    alarm[0] = 1;
}

// Se estiver desenhando opções, NÃO deixa a tecla avançar o diálogo
if (op_draw) {
    exit;
}

// Tecla para pular/avançar
if (global.tecla) {

    var texto = texto_grid[# Infos.Texto, pagina];
    var len = string_length(texto);

    // 1) Se ainda está escrevendo -> pula pro final
    if (caractere < len) {
        caractere = len;

        // corta o som imediatamente (se você estiver usando voice_id)
        if (voice_id != -1 && audio_is_playing(voice_id)) {
            audio_stop_sound(voice_id);
        }
        voice_id = -1;
        voice_asset = noone;
        alarm[0] = -1;
    }
    else {
        // 2) Se já terminou -> ou avança página, ou vai pra opções, ou fecha

        // se tem próxima página
        if (pagina < ds_grid_height(texto_grid) - 1) {
            pagina++;
            caractere = 0;
            alarm[0] = 1;
        }
        else {
            // 3) acabou as páginas: se tiver opção, só ativa as opções
            if (op_num != 0) {
                op_draw = true;

                // MUITO IMPORTANTE: zera a tecla aqui pra não selecionar na mesma apertada
                global.tecla = false;
            }
            else {
			    // 4) sem opção: encerra o diálogo

			    // IMPORTANTÍSSIMO: consome a tecla pra não reabrir no mesmo frame
			    global.tecla = false;

			    // (opcional, mas recomendado) garante que o som não fique tocando
			    if (voice_id != -1 && audio_is_playing(voice_id)) {
			        audio_stop_sound(voice_id);
			    }
			    voice_id = -1;
			    voice_asset = noone;
			    alarm[0] = -1;

			    global.dialogo = false;
			    instance_destroy();
			}
        }
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