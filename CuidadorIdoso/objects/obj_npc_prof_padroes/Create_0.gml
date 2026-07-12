event_inherited();
nome_npc      = "Professor de padroes"
indice_quest  = 1;

dialogo_ativo      = false;
dialogo_concluido  = false;
linha_atual        = 0;
texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

falas[0] = "...";
falas[1] = "...";
num_falas = 2;

function iniciar_interacao() {
    if obj_quest_gerenciador.quest_completa[indice_quest] exit;
    if !obj_quest_gerenciador.quest_disponivel(indice_quest) exit;

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
    obj_quest_gerenciador.abrir_quest(1); // overlay do prontuário
}