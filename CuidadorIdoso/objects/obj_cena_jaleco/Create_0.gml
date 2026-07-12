event_inherited();

nome_npc = "Professora Coordenadora";

// =========================================
// SPRITES
// =========================================
spr_aluna        = portrait_pmn;       // troque pelo nome real
spr_professora   = portrait_IN;  // troque pelo nome real
spr_jaleco_icone = spr_item_jaleco;              // sprite do item jaleco

// =========================================
// ESTADO DO DIALOGO (jaleco / incentivo)
// =========================================
dialogo_ativo   = false;
linha_atual     = 0;
ja_jogou_cena   = false;
modo_dialogo    = "jaleco"; // "jaleco" | "incentivo"

texto_atual        = "";
char_index          = 0;
timer_digitar       = 0;
velocidade          = 1;
digitacao_completa  = false;

mostrar_entrega_jaleco = false;
entrega_timer          = 0;

// Falas da cena do jaleco
falas_jaleco[0] = { falante: "aluna",
    texto: "Nossa... vestir esse jaleco e muita responsabilidade. Ainda me sinto insegura. Como me organizar? O que fazer num momento inesperado?" };
falas_jaleco[1] = { falante: "professora",
    texto: "Essa duvida e importante. Cuidar bem nao e agir no impulso. E preciso aprender a observar, organizar e decidir." };
falas_jaleco[2] = { falante: "professora",
    texto: "Va ate a sala de informatica. Hoje, quatro professores do Instituto Federal de Sergipe estao oferecendo uma formacao que pode te ajudar." };
falas_jaleco[3] = { falante: "professora",
    texto: "Tome, leve este jaleco com voce. Ele e seu a partir de agora." };
num_falas_jaleco = 4;

// Falas de incentivo (quando faltam professores)
falas_incentivo[0] = { falante: "professora",
    texto: "Ainda faltam professores para voce visitar na sala de informatica. Volte quando tiver conversado com todos eles." };
num_falas_incentivo = 1;

// =========================================
// ESTADO DO QUIZ INTEGRADOR
// =========================================
qz_ativo               = false;
qz_fase                = 0; // 0=pergunta | 1=resultado | 2=recompensa
qz_pergunta_atual      = 0;
qz_num_perguntas       = 4;
qz_acertos             = 0;
qz_resposta_selecionada = -1;
qz_resposta_revelada    = false;

qz_perguntas[0] = "Antes de uma visita domiciliar, voce organiza jaleco, cracha, ficha de acompanhamento e o endereco da residencia em grupos separados. Qual pilar voce esta aplicando?";
qz_opcoes0[0] = "A) Reconhecimento de Padroes";
qz_opcoes0[1] = "B) Decomposicao";
qz_opcoes0[2] = "C) Abstracao";
qz_opcoes0[3] = "D) Criacao de Algoritmos";
qz_correta[0] = 1;
qz_explicacao[0] = "Dividir a tarefa grande em partes menores (vestir, levar, conferir) e Decomposicao.";

qz_perguntas[1] = "Voce percebe que um idoso fica agitado nos dias em que toma suco industrializado no lanche da manha. Qual pilar permitiu essa descoberta?";
qz_opcoes1[0] = "A) Decomposicao";
qz_opcoes1[1] = "B) Abstracao";
qz_opcoes1[2] = "C) Reconhecimento de Padroes";
qz_opcoes1[3] = "D) Criacao de Algoritmos";
qz_correta[1] = 2;
qz_explicacao[1] = "Identificar a correlacao entre o lanche e a agitacao, observando o historico, e Reconhecimento de Padroes.";

qz_perguntas[2] = "Durante a passagem de plantao, a colega fala sobre bolo, novela e transito, mas voce registra apenas a tosse seca e a alteracao na urina. Qual pilar voce usou?";
qz_opcoes2[0] = "A) Abstracao";
qz_opcoes2[1] = "B) Criacao de Algoritmos";
qz_opcoes2[2] = "C) Decomposicao";
qz_opcoes2[3] = "D) Reconhecimento de Padroes";
qz_correta[2] = 0;
qz_explicacao[2] = "Filtrar o ruido e extrair apenas os dados clinicos essenciais e Abstracao.";

qz_perguntas[3] = "Para transferir Dona Silvia da cama para a cadeira com seguranca, voce seguiu uma sequencia fixa: explicar, posicionar, travar, aguardar, executar. Qual pilar isso representa?";
qz_opcoes3[0] = "A) Reconhecimento de Padroes";
qz_opcoes3[1] = "B) Abstracao";
qz_opcoes3[2] = "C) Decomposicao";
qz_opcoes3[3] = "D) Criacao de Algoritmos";
qz_correta[3] = 3;
qz_explicacao[3] = "Seguir passos ordenados e rigorosos para garantir seguranca e Criacao de Algoritmos.";

qz_opcoes_todas[0] = qz_opcoes0;
qz_opcoes_todas[1] = qz_opcoes1;
qz_opcoes_todas[2] = qz_opcoes2;
qz_opcoes_todas[3] = qz_opcoes3;

qz_texto_aprovacao = "Muito bem! Voce demonstrou compreender os quatro pilares do pensamento computacional:\n\nDecomposicao, Reconhecimento de Padroes, Abstracao e Criacao de Algoritmos.\n\nAgora voce ja tem uma base para organizar seu pensamento.\nO proximo passo sera aplicar isso em situacoes reais do cuidado.";
qz_texto_revisao = "Voce acertou algumas, mas vale revisar os conceitos com calma antes de seguir.\n\nVamos repassar juntas o que cada pilar significa, para que a proxima etapa seja ainda mais segura.";

// =========================================
// FUNCOES
// =========================================

function iniciar_interacao() {
    // MODO 1 -- cena do jaleco (primeira vez)
    if !ja_jogou_cena {
        modo_dialogo = "jaleco";
        dialogo_ativo = true;
        linha_atual   = 0;
        iniciar_linha();
        return;
    }

    // Verifica progresso das 4 quests
    var todas_completas = true;
    var i = 0;
    repeat (4) {
        if !obj_quest_gerenciador.quest_completa[i] { todas_completas = false; }
        i++;
    }

    // MODO 3 -- quiz (todas completas, integradora pendente)
    if todas_completas && !obj_quest_gerenciador.integradora_completa {
        abrir_quiz();
        return;
    }

    // Ja fez a integradora -- nada a fazer aqui
    if obj_quest_gerenciador.integradora_completa {
        return;
    }

    // MODO 2 -- incentivo (faltam professores)
    modo_dialogo  = "incentivo";
    dialogo_ativo = true;
    linha_atual   = 0;
    iniciar_linha();
}

function iniciar_linha() {
    texto_atual        = "";
    char_index          = 0;
    digitacao_completa  = false;
    mostrar_entrega_jaleco = false;
}

// Retorna o texto da fala atual, dependendo do modo
function obter_fala_texto() {
    if modo_dialogo == "jaleco" {
        return falas_jaleco[linha_atual].texto;
    }
    return falas_incentivo[linha_atual].texto;
}

function obter_fala_falante() {
    if modo_dialogo == "jaleco" {
        return falas_jaleco[linha_atual].falante;
    }
    return falas_incentivo[linha_atual].falante;
}

function obter_num_falas() {
    if modo_dialogo == "jaleco" {
        return num_falas_jaleco;
    }
    return num_falas_incentivo;
}

// =========================================
// FUNCOES DO QUIZ
// =========================================

function abrir_quiz() {
    qz_ativo                = true;
    qz_fase                 = 0;
    qz_pergunta_atual       = 0;
    qz_acertos              = 0;
    qz_resposta_selecionada = -1;
    qz_resposta_revelada    = false;
}

function fechar_quiz() {
    qz_ativo = false;
}