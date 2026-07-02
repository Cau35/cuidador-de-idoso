

opcao_selecionada = 0;
total_opcoes = 3;


volume_global = 1; // 0 a 1
tela_cheia = window_get_fullscreen();


menu_x = room_width / 2;
menu_y = room_height / 2 - 50;
espacamento = 60;


room_anterior = GameMenu;



if (file_exists("config.ini")) {
    ini_open("config.ini");
    volume_global = ini_read_real("audio", "volume", 1);
    tela_cheia = ini_read_real("video", "tela_cheia", 0);
    ini_close();
    
  
    audio_master_gain(volume_global);
    window_set_fullscreen(tela_cheia);
}
