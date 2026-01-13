switch(global.player)
{
	case 0: player = new Personagem_CuidadorSJ(); break;
	case 1: player = new Personagem_CuidadorCJ(); break;
}

velh = 0; 
velv = 0; 
vel = 1;

up = 0 
down = 0 
left = 0 
right = 0

sprite_index = player.sprite_idle

pega_input = function() { 
	up = keyboard_check(vk_up); 
	down = keyboard_check(vk_down); 
	left = keyboard_check(vk_left); 
	right = keyboard_check(vk_right); 
}

estado = noone;

estado_idle = function()

{
	sprite_index = player.sprite_idle;


	pega_input();

//Se a pessoa apertou alguma tecla, eu saio do estado

	if (up xor down or right xor left)

	{
		estado = estado_walk;
	}

}

estado_walk = function()

{
	pega_input();

	sprite_index = player.sprite_walk;

	velh = (right - left) * vel;

	velv = (down - up) * vel;

	if (velh == 0 && velv == 0) estado = estado_idle;

	//0lhando para o lado certo

	if (velh != 0)

	{
	image_xscale = sign(velh);
	}

}

estado = estado_idle