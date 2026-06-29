if(file_exists("save.ini"))file_delete("save.ini");
ini_open("save.ini");
ini_write_real("jogador", "x_atual", Obj_player_2.x);
ini_write_real("jogador", "y_atual", Obj_player_2.y);
ini_close();
show_message("salvo")