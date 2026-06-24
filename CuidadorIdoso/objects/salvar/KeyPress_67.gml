if(file_exists("save.ini"))file_delete("save.ini");
ini_open("save.ini");
ini_write_real("jogador", "x_atual", obj_player.x);
ini_write_real("jogador", "y_atual", obj_player.y);
ini_close();
show_message("salvo")