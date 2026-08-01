if instance_exists(obj_npc_prof_decomposicao) {
    if obj_npc_prof_decomposicao.dialogo_ativo exit;
}
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.pre_quiz_ativo) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.tablet_dialogo_ativo) exit;

if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.qz_ativo) exit;

if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.pausado) exit;
if (instance_exists(obj_npc_prof_abstracao) && obj_npc_prof_abstracao.dialogo_ativo) exit;
if (instance_exists(obj_npc_prof_padroes) && obj_npc_prof_padroes.dialogo_ativo) exit;
if (instance_exists(obj_npc_prof_algoritmos) && obj_npc_prof_algoritmos.dialogo_ativo) exit;

if (instance_exists(obj_idoso_quest_gerenciador)
    && obj_idoso_quest_gerenciador.quest_ativa) exit;

if (instance_exists(obj_quest_gerenciador)
    && obj_quest_gerenciador.quest_overlay_ativa != -1) exit;
if (instance_exists(obj_gerenciador) && obj_gerenciador.mostrar_fala_professor) exit;


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
var spr_andar_baixo_sj = spr_pmsj_andando_baixo;      
var spr_andar_cima_sj  = spr_pmsj_andando_cima;   
var spr_andar_lado_sj  = spr_pmsj_caminhando_direita;  


var spr_idle_baixo_cj  = spr_player_idle_com_jaleco;  
var spr_andar_baixo_cj = Sprite170;
var spr_andar_cima_cj  = Sprite169;
var spr_andar_lado_cj  = spr_pmcj_caminhando_direita;  

var tem_jaleco = instance_exists(obj_quest_gerenciador)
    && obj_quest_gerenciador.jaleco_vestido;


// --- INÍCIO DA ATUALIZAÇÃO DOS INPUTS ---

// 1. Checa as direções no teclado
var input_x = (keyboard_check(vk_right) || keyboard_check(ord("D")))
            - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
var input_y = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
            - (keyboard_check(vk_up)    || keyboard_check(ord("W")));

// Captura as ações no teclado
var tecla_interagir = keyboard_check_pressed(ord("E"));     
var tecla_cancelar  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_shift); 

// 2. Procura qual controle está conectado (busca do slot 0 ao 11)
var gp_id = -1;
for (var i = 0; i < 12; i++) {
    if (gamepad_is_connected(i)) {
        gp_id = i;
        break; // Encontrou um controle, para de procurar
    }
}

// Se encontrou algum controle, faz a leitura
if (gp_id != -1) {
    var deadzone = 0.2;
    gamepad_set_axis_deadzone(gp_id, deadzone);
    
    // Captura analógico
    var axis_h = gamepad_axis_value(gp_id, gp_axislh);
    var axis_v = gamepad_axis_value(gp_id, gp_axislv);
    
    // Captura D-pad (setinhas do controle)
    var dpad_h = gamepad_button_check(gp_id, gp_padr) - gamepad_button_check(gp_id, gp_padl);
    var dpad_v = gamepad_button_check(gp_id, gp_padd) - gamepad_button_check(gp_id, gp_padu);
    
    // Sobrescreve o input de movimento se o controle estiver sendo usado
    if (abs(axis_h) > deadzone || abs(dpad_h) > 0) input_x = clamp(axis_h + dpad_h, -1, 1);
    if (abs(axis_v) > deadzone || abs(dpad_v) > 0) input_y = clamp(axis_v + dpad_v, -1, 1);
    
    // Captura os botões de ação do controle
    if (gamepad_button_check_pressed(gp_id, gp_face4)) tecla_interagir = true; // Triângulo (PS) / Y (Xbox)
    if (gamepad_button_check_pressed(gp_id, gp_face2)) tecla_cancelar  = true; // Bola (PS) / B (Xbox)
}

// 3. Normalização atualizada para funcionar bem com analógicos e teclados
var dist = point_distance(0, 0, input_x, input_y);
if (dist > 1) {
    input_x /= dist;
    input_y /= dist;
}

// --- FIM DA ATUALIZAÇÃO DOS INPUTS ---


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