event_inherited();

if dialogo_ativo {
    // Digitação
    if !digitacao_completa {
        timer_digitar++;
        if timer_digitar >= 1 {
            timer_digitar = 0;
            if char_index < string_length(falas[linha_atual]) {
                char_index++;
                texto_atual = string_copy(falas[linha_atual], 1, char_index);
            } else {
                digitacao_completa = true;
            }
        }
    }

   
    if keyboard_check_pressed(ord("E")) {
        if !digitacao_completa {
            texto_atual = falas[linha_atual];
            char_index  = string_length(falas[linha_atual]);
            digitacao_completa = true;
        } else if linha_atual < num_falas-1 {
            linha_atual++;
            iniciar_linha();
        } else {
            
            dialogo_ativo = false;
            room_goto(room_deomposicao);
        }
    }
}