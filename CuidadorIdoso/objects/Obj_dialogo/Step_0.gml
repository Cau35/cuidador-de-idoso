// Inicialização do diálogo
if (inicializar == false) {
    scr_textos();
    inicializar = true;
    alarm[0] = 1;
}

// Clique para avançar / pular texto
if global.tecla{

    var texto = texto_grid[# Infos.Texto, pagina];
    var len = string_length(texto);

    // SE AINDA ESTÁ ESCREVENDO → PULA PARA O FINAL
    if (caractere < len) {

        caractere = len;

        // corta o som imediatamente
        if (voice_id != -1 && audio_is_playing(voice_id)) {
            audio_stop_sound(voice_id);
        }

        voice_id = -1;
        voice_asset = noone;
        alarm[0] = -1;

    }
    // SE JÁ TERMINOU → AVANÇA DIÁLOGO
    else {

        // garante que nenhum som fique tocando
        if (voice_id != -1 && audio_is_playing(voice_id)) {
            audio_stop_sound(voice_id);
        }

        voice_id = -1;
        voice_asset = noone;

        caractere = 0;

        if (pagina < ds_grid_height(texto_grid) - 1) {
            pagina++;
            alarm[0] = 1;
        }
        else {
			if op_num != 0{
				op_draw = true;
			}else{
	            global.dialogo = false;
	            instance_destroy();
	        }
	    }
	}
}