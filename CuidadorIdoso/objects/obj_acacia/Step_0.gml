direita  = keyboard_check(ord("D"));
cima     = keyboard_check(ord("W"));
esquerda = keyboard_check(ord("A"));
baixo    = keyboard_check(ord("S"));

hveloc = (direita - esquerda) * veloc;
x += hveloc;

vveloc = (baixo - cima) * veloc;
y += vveloc;


//Direção

dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45)/90);

switch dir{
	default:
	  sprite_index = spr_acacia_parada_direita
    break;
	case 1:
      sprite_index = spr_acacia_parada_cima
    break;
	case 2:
	  sprite_index = spr_acacia_parada_esquerda
	break;
	case 3:
	  sprite_index = spr_acacia_parada_baixo
	break;
}
	