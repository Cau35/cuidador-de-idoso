event_inherited();
nome_npc      = "Elisa";
indice_quest  = 0;

dialogo_ativo      = false;
dialogo_concluido  = false;
linha_atual        = 0;
texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

falas = [
    "Agora vamos aprender sobre decomposição, uma habilidade muito importante para resolver problemas. Quando uma tarefa parece grande ou complicada, a melhor estratégia é dividi-la em partes menores e mais fáceis de organizar.",
    "Neste desafio, imagine que você está se preparando para uma visita domiciliar.",
    "Arraste cada item para a caixa correspondente à etapa em que ele será utilizado: o que preciso vestir/usar, o que preciso levar para registrar o cuidado e o que preciso conferir antes de sair. Vamos começar o desafio?"
];
num_falas = array_length(falas);

function iniciar_interacao() {
    if obj_quest_gerenciador.quest_completa[indice_quest] exit;
    if !obj_quest_gerenciador.quest_disponivel(indice_quest) exit;

    if !dialogo_concluido {
    
        dialogo_ativo = true;
        linha_atual   = 0;
        iniciar_linha();
    } else {
     
        abrir_quest_desta_estacao();
    }
}

function iniciar_linha() {
    texto_atual        = "";
    char_index         = 0;
    digitacao_completa = false;
}

function abrir_quest_desta_estacao() {
    room_goto(room_deomposicao); 
}

