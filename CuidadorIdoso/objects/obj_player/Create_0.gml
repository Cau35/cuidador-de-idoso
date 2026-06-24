if (!variable_global_exists("pegar_jaleco")){
	global.pegar_jaleco = false;
}





velh = 0; 
velv = 0; 
vel = 1;

up = 0 
down = 0 
left = 0 
right = 0

image_xscale = 0.3;
image_yscale = 0.3;



pega_input = function() { 
	up = keyboard_check(vk_up); 
	down = keyboard_check(vk_down); 
	left = keyboard_check(vk_left); 
	right = keyboard_check(vk_right); 
}

estado = noone;

estado_idle = function()

{
	
	pega_input();

	if (up xor down or right xor left)

	{
		estado = estado_walk;
	}

}

estado_walk = function()

{
	pega_input();

	

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