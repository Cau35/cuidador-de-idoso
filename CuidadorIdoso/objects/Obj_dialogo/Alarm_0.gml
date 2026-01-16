if inicializar == true{
	if caractere < string_length(texto_grid[# Infos.Texto, pagina]){
		var _snd = choose(snd_voice_1, snd_voice_2);
		audio_play_sound(_snd, 1, 0);
		caractere++;
		alarm[0] = 1;
	}
}