event_inherited(); 

nome_npc = "Professora Coordenadora";


spr_aluna      = portrait_pmn       
spr_professora = noone;  
spr_jaleco_icone = spr_item_jaleco;            


dialogo_ativo   = false;
linha_atual     = 0;
ja_jogou_cena   = false;


falas[0] = { falante: "aluna",
    texto: "Nossa... vestir esse jaleco é muita responsabilidade. Ainda me sinto insegura. Como me organizar? O que fazer num momento inesperado?" };

falas[1] = { falante: "professora",
    texto: "Essa dúvida é importante. Cuidar bem não é agir no impulso. É preciso aprender a observar, organizar e decidir." };

falas[2] = { falante: "professora",
    texto: "Vá até a sala de informática. Hoje, quatro professores do Instituto Federal de Sergipe estão oferecendo uma formação que pode te ajudar." };

falas[3] = { falante: "professora",
    texto: "Tome, leve este jaleco com você. Ele é seu a partir de agora." };

num_falas = 4;


texto_atual = "";
char_index = 0;
timer_digitar = 0;
velocidade = 1;
digitacao_completa = false;


mostrar_entrega_jaleco = false;
entrega_timer = 0;


function iniciar_interacao() {
    if ja_jogou_cena {
       
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
