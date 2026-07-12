event_inherited();
nome_npc      = "acacia";



dialogo_ativo      = false;
dialogo_concluido  = false;
linha_atual        = 0;
texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

falas[0] = "Bem-vinda! Antes de qualquer coisa, precisamos aprender a dividir problemas grandes em partes menores.";
falas[1] = "Isso se chama Decomposicao. Vamos praticar com um desafio real de cuidado domiciliar!";
num_falas = 2;

function iniciar_interacao() {
    // Ja concluiu -- nao abre mais
    if obj_quest_gerenciador.quest_idoso_concluida exit;

    if !obj_quest_gerenciador.quest_idoso_disponivel() {
        // Bloqueada
        exit;
    }

    if instance_exists(obj_idoso_quest_gerenciador) {
        // So abre se nao estiver ja ativa
        if !obj_idoso_quest_gerenciador.quest_ativa {
            obj_idoso_quest_gerenciador.quest_ativa = true;
            obj_idoso_quest_gerenciador.iniciar_mini_quest(0);
        }
    } else {
        room_goto(rm_casa_idoso);
    }
}

function iniciar_linha() {
    texto_atual        = "";
    char_index         = 0;
    digitacao_completa = false;
}

