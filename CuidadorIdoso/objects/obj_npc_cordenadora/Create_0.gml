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
   


    if !dialogo_concluido {
        // Abre o diálogo primeiro
        dialogo_ativo = true;
        linha_atual   = 0;
        iniciar_linha();
    } else {
        // Diálogo já foi visto — vai direto para a quest
        abrir_quest_desta_estacao();
    }
}

function iniciar_linha() {
    texto_atual        = "";
    char_index         = 0;
    digitacao_completa = false;
}

function abrir_quest_desta_estacao() {

    if !obj_quest_gerenciador.quest_idoso_disponivel() {
        // Ainda bloqueada — mostra mensagem
        show_debug_message("Complete a formacao e a avaliacao final primeiro.");
        // Integre com seu sistema de dialogo aqui
        exit;
    }
    // Abre a quest do idoso
    obj_idoso_quest_gerenciador.quest_ativa = true;
    obj_idoso_quest_gerenciador.iniciar_mini_quest(0);
}

