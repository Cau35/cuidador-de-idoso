/// scr_personagens

function Personagem_CuidadoraSJ() constructor {
	
	sprite_idle = spr_jogador_idle_sem_jaleco
	sprite_walk = spr_pmsj_caminhando_direita
}
function Personagem_CuidadoraCJ() constructor {
	
	sprite_idle = spr_player_idle_com_jaleco
	sprite_walk = spr_pmcj_caminhando_direita
}

global.player = 0;