event_inherited();
nome_npc      = "Raviel"
indice_quest  = 1;

dialogo_ativo      = false;
dialogo_concluido  = false;
linha_atual        = 0;
texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

falas[0] = "Reconhecimento de padrões é a habilidade de observar informações e perceber o que se repete. No cuidado com a pessoa idosa, isso é muito importante, porque sinais repetidos podem indicar que algo não está bem. Um comportamento isolado pode não dizer muita coisa, mas quando ele aparece várias vezes, precisamos prestar atenção.";
falas[1] = "Agora você vai analisar três prontuários médicos de uma mesma pessoa idosa. Observe os registros com atenção e descubra qual variável se repete. Essa repetição pode ajudar a entender a causa da agitação do idoso. Compare os prontuários, identifique o padrão e escolha a resposta correta.";
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