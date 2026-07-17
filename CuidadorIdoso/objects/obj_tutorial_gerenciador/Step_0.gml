if (tempo_restante > 0) {
    // Subtrai o equivalente a 1 segundo por segundo real
    tempo_restante -= 1 / game_get_speed(gamespeed_fps);
} else {
    tempo_restante = 0;
    
    // O tempo acabou! Leva para a outra sala
    room_goto(rm_inicio);
}