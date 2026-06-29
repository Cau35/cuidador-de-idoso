 arrastando = false;
depth = 0;
var solto_em_caixa = false;

with (obj_caixa) {
    if point_in_rectangle(other.x, other.y, bbox_left, bbox_top, bbox_right, bbox_bottom) {
        solto_em_caixa = true;

        
        var respostas = obj_gerenciador.caixa_respostas[self.indice];
        var correto = false;

        for (var i = 0; i < array_length(respostas); i++) {
            if respostas[i] == other.nome_item {
                correto = true;
                break;
            }
        }

        if correto {
            other.na_caixa_correta = true;
            other.x = self.x + irandom_range(-60, 60);
            other.y = self.y + irandom_range(-30, 30);
            // Feedback positivo
            with (obj_gerenciador) {
                feedback_texto = "✓ Item correto!";
                feedback_cor = c_green;
                mostrar_feedback = true;
                feedback_timer = 90;
            }
        } else if other.eh_distrator {
            // É distrator: devolve à origem
            other.x = other.pos_origem_x;
            other.y = other.pos_origem_y;
            with (obj_gerenciador) {
                feedback_texto = "Esse item não é essencial para a visita.";
                feedback_cor = c_orange;
                mostrar_feedback = true;
                feedback_timer = 100;
            }
        } else {
            
            other.x = other.pos_origem_x;
            other.y = other.pos_origem_y;
            with (obj_gerenciador) {
                feedback_texto = "Esse item vai em outra categoria. Tente novamente!";
                feedback_cor = c_red;
                mostrar_feedback = true;
                feedback_timer = 100;
            }
        }
        break;
    }
}


if !solto_em_caixa {
    x = pos_origem_x;
    y = pos_origem_y;
}