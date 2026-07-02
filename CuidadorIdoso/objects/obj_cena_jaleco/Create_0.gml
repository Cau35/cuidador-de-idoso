event_inherited(); // herda raio_interacao e detecção de proximidade do obj_npc

nome_npc = "Professora Coordenadora";

// === SPRITES DOS PERSONAGENS NO DIÁLOGO ===
spr_aluna      = portrait_pmn       // troque pelo nome do seu sprite
spr_professora = noone;  // troque pelo nome do seu sprite
spr_jaleco_icone = noone;            // sprite do item jaleco (ícone pequeno)

// === ESTADO DO DIÁLOGO ===
dialogo_ativo   = false;
linha_atual     = 0;
ja_jogou_cena   = false; // evita repetir a cutscene depois de concluída

// === LINHAS DO DIÁLOGO ===
// falante: "aluna" ou "professora"
falas[0] = { falante: "aluna",
    texto: "Nossa... vestir esse jaleco é muita responsabilidade. Ainda me sinto insegura. Como me organizar? O que fazer num momento inesperado?" };

falas[1] = { falante: "professora",
    texto: "Essa dúvida é importante. Cuidar bem não é agir no impulso. É preciso aprender a observar, organizar e decidir." };

falas[2] = { falante: "professora",
    texto: "Vá até a sala de informática. Hoje, quatro professores do Instituto Federal de Sergipe estão oferecendo uma formação que pode te ajudar." };

falas[3] = { falante: "professora",
    texto: "Tome, leve este jaleco com você. Ele é seu a partir de agora." };

num_falas = 4;

// === EFEITO DE DIGITAÇÃO (igual ao usado na Estação 3) ===
texto_atual = "";
char_index = 0;
timer_digitar = 0;
velocidade = 1;
digitacao_completa = false;

// === ANIMAÇÃO DE ENTREGA DO JALECO ===
mostrar_entrega_jaleco = false;
entrega_timer = 0;

// === SOBRESCREVE A INTERAÇÃO HERDADA DO obj_npc ===
function iniciar_interacao() {
    if ja_jogou_cena {
        // Depois de concluída, futuras interações podem levar a um diálogo de apoio
        show_debug_message("Cutscene já concluída — diálogo de apoio aqui, se quiser.");
        exit;
    }
    dialogo_ativo = true;
    linha_atual = 0;
    iniciar_linha();
}

function iniciar_linha() {
    texto_atual = "";
    char_index = 0;
    digitacao_completa = false;
    mostrar_entrega_jaleco = false;

}
