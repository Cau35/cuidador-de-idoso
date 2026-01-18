switch(global.player)
{
	case 0: player = new Personagem_CuidadorSJ(); break;
	case 1: player = new Personagem_CuidadorCJ(); break;
	case 2: player = new Personagem_CuidadoraSJ(); break;
	case 3: player = new Personagem_CuidadoraCJ(); break; 
}

if (global.pegar_jaleco == true) {

    // Atualiza o índice do personagem
    if (global.player == 0) global.player = 1; // cuidador sem -> com jaleco
    if (global.player == 2) global.player = 3; // cuidadora sem -> com jaleco

    // Recria o personagem correto
    if (global.player == 1) {
        player = new Personagem_CuidadorCJ();
    }
    else if (global.player == 3) {
        player = new Personagem_CuidadoraCJ();
    }

    // Atualiza sprite inicial
    sprite_index = player.sprite_idle;

    // Consome o evento
    global.pegar_jaleco = false;
}

velh = 0; 
velv = 0; 
vel = 1;

up = 0 
down = 0 
left = 0 
right = 0

image_xscale = 0.4;
image_yscale = 0.4;

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
	image_xscale = abs(image_xscale) * sign(velh);
	}

}

estado = estado_idle