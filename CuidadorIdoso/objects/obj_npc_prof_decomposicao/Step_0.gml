event_inherited();

if dialogo_ativo {
    obj_quest_gerenciador.dialogo_npc_ativo = true;

    
    var texto_completo = falas[linha_atual];
    if !digitacao_completa {
        timer_digitar++;
        if timer_digitar >= 1 {
            timer_digitar = 0;
            if char_index < string_length(texto_completo) {
                char_index++;
                texto_atual = string_copy(texto_completo, 1, char_index);
            } else {
                digitacao_completa = true;
            }
        }
    }

    if keyboard_check_pressed(ord("E")){
        if !digitacao_completa {
            texto_atual = texto_completo;
            char_index  = string_length(texto_completo);
            digitacao_completa = true;
        } else if linha_atual < num_falas - 1 {
            linha_atual++;
            iniciar_linha();
        } else {
            dialogo_ativo     = false;
            dialogo_concluido = true;
            room_goto(room_deomposicao);
        }
    }
}