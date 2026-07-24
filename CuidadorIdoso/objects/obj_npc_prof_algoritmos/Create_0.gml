event_inherited();
nome_npc      = "Professor de abstracao";
indice_quest  = 3;

dialogo_ativo      = false;
dialogo_concluido  = false; // true após o jogador ver o diálogo ao menos uma vez
linha_atual        = 0;
texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

falas[0] = "Um algoritmo é uma sequência de passos organizados para realizar uma tarefa. No cuidado com a pessoa idosa, isso aparece quando seguimos uma ordem correta: primeiro observar a situação, depois preparar os materiais, executar o cuidado e, por fim, conferir se tudo ficou seguro.";
falas[1] = "Quando seguimos uma boa sequência, evitamos erros e cuidamos melhor.";
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
    room_goto(room_quest_algoritmos);
}
