
if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.pausado) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo) exit;
if (instance_exists(obj_quest_gerenciador)
    && obj_quest_gerenciador.quest_overlay_ativa != -1) exit;


if instance_exists(obj_quest_gerenciador) {
    var ger = obj_quest_gerenciador;

    if ger.porta_destino_pendente == "__load__" && ger.load_x != 0 {
        x = ger.load_x;
        y = ger.load_y;
        ger.load_x = 0;
        ger.load_y = 0;
        ger.porta_destino_pendente = "";
    } else if ger.porta_destino_pendente != "" && ger.porta_destino_pendente != "__load__" {
        var alvo_id = ger.porta_destino_pendente;
        with (obj_porta) {
            if porta_id == alvo_id {
                other.x = x + spawn_offset_x;
                other.y = y + spawn_offset_y;
            }
        }
        ger.porta_destino_pendente = "";
    }
}


var spr_idle_baixo_sj  = spr_jogador_idle_sem_jaleco;   
var spr_andar_baixo_sj = noone;      
var spr_andar_cima_sj  = noone;   
var spr_andar_lado_sj  = spr_pmcj_caminhando_direita;  


var spr_idle_baixo_cj  = spr_player_idle_com_jaleco;  
var spr_andar_baixo_cj = noone;
var spr_andar_cima_cj  = noone;
var spr_andar_lado_cj  = noone;  

var tem_jaleco = instance_exists(obj_quest_gerenciador)
    && obj_quest_gerenciador.jaleco_vestido;


var input_x = (keyboard_check(vk_right) || keyboard_check(ord("D")))
            - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
var input_y = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
            - (keyboard_check(vk_up)    || keyboard_check(ord("W")));


if input_x != 0 && input_y != 0 {
    input_x *= 0.7071;
    input_y *= 0.7071;
}

var velocidade = 4;
var mover_x = input_x * velocidade;
var mover_y = input_y * velocidade;


if mover_x != 0 {
    if !place_meeting(x + mover_x, y, obj_solido) {
        x += mover_x;
    } else {
        while !place_meeting(x + sign(mover_x), y, obj_solido) {
            x += sign(mover_x);
        }
    }
}

if mover_y != 0 {
    if !place_meeting(x, y + mover_y, obj_solido) {
        y += mover_y;
    } else {
        while !place_meeting(x, y + sign(mover_y), obj_solido) {
            y += sign(mover_y);
        }
    }
}


var movendo = (input_x != 0 || input_y != 0);

if movendo {
    
    if input_x != 0 {

        sprite_index = tem_jaleco ? spr_andar_lado_cj : spr_andar_lado_sj;

        image_xscale = (input_x < 0) ? -1 : 1;

    } else if input_y > 0 {
  
        sprite_index = tem_jaleco ? spr_andar_baixo_cj : spr_andar_baixo_sj;
        image_xscale = 1;

    } else if input_y < 0 {

        sprite_index = tem_jaleco ? spr_andar_cima_cj : spr_andar_cima_sj;
        image_xscale = 1;
    }

    image_speed = 1;

} else {
   
    sprite_index = tem_jaleco ? spr_idle_baixo_cj : spr_idle_baixo_sj;
    image_speed  = 0;      
    image_index  = 0;       
}


var half_w = sprite_width / 2;
var half_h = sprite_height / 2;

x = clamp(x, half_w, room_width - half_w);
y = clamp(y, half_h, room_height - half_h);




