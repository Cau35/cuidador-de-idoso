if (!inicializar) exit;

var texto = texto_grid[# Infos.Texto, pagina];
var len = string_length(texto);

// Ainda está digitando
if (caractere < len)
{
    var voz = texto_grid[# Infos.Voz, pagina];

    // fallback caso venha undefined
    if (is_undefined(voz) || voz == noone) voz = snd_voice_1;

    // Se mudou a voz (ou ainda não começou), liga o loop
    if (voice_id == -1 || voice_asset != voz)
    {
        // para o que estiver tocando
        if (voice_id != -1 && audio_is_playing(voice_id))
            audio_stop_sound(voice_id);

        voice_asset = voz;
        voice_id = audio_play_sound(voz, 1, true); // TRUE = loop (repete até a fala acabar)
    }

    // Avança a digitação
    caractere++;
    alarm[0] = 1; // velocidade do typing (1 rápido, 2/3 mais natural)
}
else
{
    // Terminou a fala: para o som
    if (voice_id != -1 && audio_is_playing(voice_id))
        audio_stop_sound(voice_id);

    voice_id = -1;
    voice_asset = noone;
    alarm[0] = -1;
}