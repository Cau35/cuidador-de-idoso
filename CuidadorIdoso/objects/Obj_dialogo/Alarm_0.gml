<<<<<<< HEAD
if (inicializar == true) {

    if (caractere < string_length(texto[pagina])) {
        caractere++;

        var _snd = choose(snd_voz1, snd_voz2, snd_voz3, snd_voz4);
        audio_play_sound(_snd, 1, false);

        alarm[0] = 1;
    }
=======
if (!inicializar) exit;

var texto = texto_grid[# Infos.Texto, pagina];
var len = string_length(texto);

if (caractere < len)
{
    var voz = texto_grid[# Infos.Voz, pagina];
    if (is_undefined(voz) || voz == noone) voz = snd_voice_1;

    // garante que o som da fala atual esteja tocando em loop
    if (voice_id == -1 || voice_asset != voz || !audio_is_playing(voice_id))
    {
        // para o anterior se tiver
        if (voice_id != -1 && audio_is_playing(voice_id))
            audio_stop_sound(voice_id);

        voice_asset = voz;
        voice_id = audio_play_sound(voz, 1, true); // TRUE = loop até a fala terminar
    }

    caractere++;
    alarm[0] = 1;
}
else
{
    // terminou a fala -> corta o som
    if (voice_id != -1 && audio_is_playing(voice_id))
        audio_stop_sound(voice_id);

    voice_id = -1;
    voice_asset = noone;
    alarm[0] = -1;
>>>>>>> 5f9477d1366a4e482bf8a5393228b23ddeeff7ae
}