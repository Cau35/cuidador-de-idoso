var input_x = (keyboard_check(vk_right) || keyboard_check(ord("D")))
            - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
var input_y = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
            - (keyboard_check(vk_up)    || keyboard_check(ord("W")));

show_debug_message("pausado: " + string(obj_quest_gerenciador.pausado)
    + " | dialogo: " + string(instance_exists(obj_cena_jaleco) ? obj_cena_jaleco.dialogo_ativo : false)
    + " | fala_prof: " + string(instance_exists(obj_gerenciador) ? obj_gerenciador.mostrar_fala_professor : false)
    + " | quest_concluida: " + string(instance_exists(obj_gerenciador) ? obj_gerenciador.quest_concluida : false));			// Roda só uma vez na primeira frame
if !variable_instance_exists(id, "reposicionamento_feito") {
    reposicionamento_feito = true;

    if instance_exists(obj_quest_gerenciador) {
        var ger = obj_quest_gerenciador;

        // Reposicionamento por load
        if ger.porta_destino_pendente == "__load__" {
            x = ger.load_x;
            y = ger.load_y;
            ger.porta_destino_pendente = "";

        // Reposicionamento por porta
        } else if ger.porta_destino_pendente != "" {
            var alvo_id = ger.porta_destino_pendente;
            with (obj_porta) {
                if porta_id == alvo_id {
                    other.x = x + spawn_offset_x;
                    other.y = y + spawn_offset_y;
                }
            }
            ger.porta_destino_pendente = "";
        }

        // Sprite com ou sem jaleco
        if ger.jaleco_vestido {
            sprite_index = spr_player_idle_com_jaleco;
        } else {
            sprite_index = spr_jogador_idle_sem_jaleco;
        }
    }
}

var input_x = (keyboard_check(vk_right) || keyboard_check(ord("D")))
            - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
var input_y = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
            - (keyboard_check(vk_up)    || keyboard_check(ord("W")));


if (input_x != 0) && (input_y != 0) {
    input_x *= 0.7071; 
    input_y *= 0.7071;
}

var mover_x = input_x * velocidade_movimento;
var mover_y = input_y * velocidade_movimento;

// === COLISÃO NO EIXO X ===
if mover_x != 0 {
    if !place_meeting(x + mover_x, y, obj_solido) {
        x += mover_x;
    } else {
        
        while !place_meeting(x + sign(mover_x), y, obj_solido) {
            x += sign(mover_x);
        }
    }
}

// === COLISÃO NO EIXO Y ===
if mover_y != 0 {
    if !place_meeting(x, y + mover_y, obj_solido) {
        y += mover_y;
    } else {
        while !place_meeting(x, y + sign(mover_y), obj_solido) {
            y += sign(mover_y);
        }
    }
}



var half_w = sprite_width / 2;
var half_h = sprite_height / 2;

x = clamp(x, half_w, room_width - half_w);
y = clamp(y, half_h, room_height - half_h);




