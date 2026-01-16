if (inicializar == true) {

    if (caractere < string_length(texto[pagina])) {
        caractere++;

        var _snd = choose(snd_voz1, snd_voz2, snd_voz3, snd_voz4);
        audio_play_sound(_snd, 1, false);

        alarm[0] = 1;
    }
}