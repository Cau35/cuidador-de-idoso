// ===============================
// CUTSCENE não força opções
// ===============================
if (global.cutscene_ativa) {
    op_draw = false;
}

// ===============================
// Inicialização do diálogo
// ===============================
if (!inicializar) {
    scr_textos();
    inicializar = true;
    alarm[0] = 1;
}

// ===============================
// Tecla para pular / avançar
// ===============================
if (global.tecla) {

    var texto = texto_grid[# Infos.Texto, pagina];
    var len = string_length(texto);

    // ===========================
    // 1) Ainda escrevendo → pular
    // ===========================
    if (caractere < len) {
        caractere = len;

        // corta o som imediatamente
        if (voice_id != -1 && audio_is_playing(voice_id)) {
            audio_stop_sound(voice_id);
        }

        voice_id = -1;
        voice_asset = noone;
        alarm[0] = -1;

        global.tecla = false;
    }
    else {
        // ===========================
        // 2) Texto acabou
        // ===========================

        // ainda existem páginas
        if (pagina < ds_grid_height(texto_grid) - 1) {
            pagina++;
            caractere = 0;
            alarm[0] = 1;
            global.tecla = false;
        }
        else {
            // ===========================
            // 3) Fim do diálogo
            // ===========================

            // tem opções → só mostra opções
            if (op_num > 0) {
                op_draw = true;
                global.tecla = false;
            }
            else {
                // ===========================
                // 4) Encerra diálogo
                // ===========================

                global.tecla = false;

                // garante que nenhum som fique tocando
                if (voice_id != -1 && audio_is_playing(voice_id)) {
                    audio_stop_sound(voice_id);
                }

                voice_id = -1;
                voice_asset = noone;
                alarm[0] = -1;

                global.dialogo = false;

                // ===========================
                // 🔥 Troca de sala (cutscene)
                // ===========================
                if (variable_global_exists("cutscene_next_room")) {
                    var _rm = global.cutscene_next_room;
                    variable_global_remove("cutscene_next_room");
                    instance_destroy();
                    room_goto(_rm);
                    return;
                }

                instance_destroy();
            }
        }
    }
}