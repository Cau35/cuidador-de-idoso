event_inherited();
nome_npc = "Professor de Decomposicao";
indice_quest = 0;


dialogo_ativo = false;
linha_atual   = 0;


falas = [
    "Agora vamos aprender sobre decomposição, uma habilidade muito importante para resolver problemas.Quando uma tarefa parece grande ou complicada, a melhor estratégia é dividi-la em partes menores e mais fáceis de organizar. ",
    ". Neste desafio, imagine que você está se preparando para uma visita domiciliar. ",
    "Arraste cada item para a caixa correspondente à etapa em que ele será utilizado: o que preciso vestir/usar, o que preciso levar para registrar o cuidado e o que preciso conferir antes de sair. Vamos comecar o desafio?"
];
num_falas = array_length(falas);

texto_atual        = "";
char_index         = 0;
timer_digitar      = 0;
digitacao_completa = false;

function iniciar_interacao() {
    if obj_quest_gerenciador.quest_completa[0] exit;
    dialogo_ativo = true;
    linha_atual   = 0;
    iniciar_linha();
}

function iniciar_linha() {
    texto_atual        = "";
    char_index         = 0;
    digitacao_completa = false;
}