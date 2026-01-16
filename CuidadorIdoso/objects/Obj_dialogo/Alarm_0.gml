if (inicializar)
{
    var texto = texto_grid[# Infos.Texto, pagina];

    if (caractere < string_length(texto))
    {
        var voz = texto_grid[# Infos.Voz, pagina];

        // só tenta parar se já existir um som tocando
        if (voice_id != -1 && audio_is_playing(voice_id))
        {
            audio_stop_sound(voice_id);
        }

        // toca a voz da linha atual
        voice_id = audio_play_sound(voz, 1, false);

        // avança o efeito de digitação
        caractere++;
        alarm[0] = 2; // controla a velocidade do som/digitação
    }
}
