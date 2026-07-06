if !arrastando exit;
arrastando = false;
depth = 0;

var ger = gerenciador;
var solto_em_slot = false;

for (var s = 0; s < ger.num_slots; s++) {
    var sx = ger.slot_x;
    var sy = ger.slot_y_inicio + s * (ger.slot_altura + ger.slot_gap);
    var sw = ger.slot_largura;
    var sh = ger.slot_altura;

    if point_in_rectangle(x + largura/2, y + altura/2,
        sx, sy, sx+sw, sy+sh) {

        if ger.slot_conteudo[s] != -1 && ger.slot_conteudo[s] != indice {
            x = pos_origem_x;
            y = pos_origem_y;
            no_slot = -1;
            exit;
        }

        ger.slot_conteudo[s] = indice;
        no_slot = s;

        x = sx + 2;
        y = sy + 2;
        largura = sw - 4;
        altura  = sh - 4;

        if ger.ordem_correta[s] == indice {
            ger.slot_correto[s] = true;
            ger.slot_errado[s]  = false;
            fixado = true;
            obj_quest_gerenciador.ganhar_moedas(5); // moeda por bloco correto
        } else {
            ger.slot_correto[s] = false;
            ger.slot_errado[s]  = true;
        }

        solto_em_slot = true;
        ger.verificar_conclusao();
        break;
    }
}

if !solto_em_slot {
    x = pos_origem_x;
    y = pos_origem_y;
    largura = 660;
    altura  = 80;
    no_slot = -1;
}