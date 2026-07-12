porta_destino_pendente = "";
load_x = 0;
load_y = 0;


gui_w = display_get_gui_width();   
gui_h = display_get_gui_height();  

escala_x = gui_w / 1280;
escala_y = gui_h / 720;

jaleco_vestido = false;






if instance_number(obj_quest_gerenciador) > 1 {
    instance_destroy();
    exit;
}
persistent = true;


quest_completa[0] = false; // Estação 1 — Decomposição
quest_completa[1] = false; // Estação 2 — Reconhecimento de Padrões
quest_completa[2] = false; // Estação 3 — Abstração
quest_completa[3] = false; // Estação 4 — Criação de Algoritmos

quest_nome[0] = "Decomposição";
quest_nome[1] = "Reconhecimento de Padrões";
quest_nome[2] = "Abstração";
quest_nome[3] = "Criação de Algoritmos";

integradora_completa = false;
tablet_recebido = true;


inventario = [];
objetivos = ["Visitar os 4 professores na sala de informática"];

mensagens = [
    { remetente: "Professora Coordenadora",
      texto: "Bem-vinda à formação! Visite os 4 professores na sala de informática para aprender as bases do pensamento computacional." }
];

saldo_moedas = 0;


tablet_aberto = false;
tablet_aba = 0;


hud_npc_perto = false;
hud_npc_nome  = "";
hud_npc_perto_proximo_frame = false;
hud_npc_nome_proximo_frame  = "";
hud_moeda_anim = 0;
spr_icone_moeda = -1; 

function marcar_quest_completa(_indice) {
    quest_completa[_indice] = true;
    verificar_todas_completas();
}



function verificar_todas_completas() {
	
    var todas = true;
    for (var i = 0; i < 4; i++) {
        if !quest_completa[i] { todas = false; break; }
    }
    if todas && !integradora_completa {
        objetivos[array_length(objetivos)] = "Realizar a Avaliação Final com a Professora";
        array_push(mensagens, {
            remetente: "Professora Coordenadora",
            texto: "Você visitou os 4 professores! Volte até mim para a avaliação final."
        });
    }
}

function dar_tablet() {
    tablet_recebido = true;
    array_push(inventario, "Tablet");
    array_push(mensagens, {
        remetente: "Sistema",
        texto: "Você recebeu um Tablet! Use-o para consultar seus objetivos, mensagens e progresso."
    });
}

function nova_mensagem(_remetente, _texto) {
    array_push(mensagens, { remetente: _remetente, texto: _texto });
}

function set_npc_proximo(_nome) {
    hud_npc_perto_proximo_frame = true;
    hud_npc_nome_proximo_frame  = _nome;
}

function ganhar_moedas(_qtd) {
    saldo_moedas += _qtd;
    hud_moeda_anim = 12;
}

pausado = false;
pause_aba = 0;




save_file = game_save_id + "save01.ini";
save_slot_existe = file_exists(save_file);



function salvar_jogo() {
    ini_open(save_file);

    
    ini_write_real("quests", "quest_0", quest_completa[0]);
    ini_write_real("quests", "quest_1", quest_completa[1]);
    ini_write_real("quests", "quest_2", quest_completa[2]);
    ini_write_real("quests", "quest_3", quest_completa[3]);
    ini_write_real("quests", "integradora", integradora_completa);
    ini_write_real("quests", "jaleco_vestido", jaleco_vestido);
    ini_write_real("quests", "tablet_recebido", tablet_recebido);

    
    ini_write_real("jogador", "moedas", saldo_moedas);


    if instance_exists(Obj_player) {
        ini_write_real("jogador", "x", Obj_player.x);
        ini_write_real("jogador", "y", Obj_player.y);
        ini_write_string("jogador", "room", room_get_name(room));
    }

    
    ini_write_real("inventario", "total", array_length(inventario));
    for (var i = 0; i < array_length(inventario); i++) {
        ini_write_string("inventario", "item_" + string(i), inventario[i]);
    }

    ini_close();
    save_slot_existe = true;
	show_debug_message("Save em: " + working_directory + save_file);
    show_debug_message("Jogo salvo com sucesso.");
	
}

function carregar_jogo() {
    if !file_exists(save_file) exit;

    ini_open(save_file);

    quest_completa[0]    = bool(ini_read_real("quests", "quest_0",        0));
    quest_completa[1]    = bool(ini_read_real("quests", "quest_1",        0));
    quest_completa[2]    = bool(ini_read_real("quests", "quest_2",        0));
    quest_completa[3]    = bool(ini_read_real("quests", "quest_3",        0));
    integradora_completa = bool(ini_read_real("quests", "integradora",    0));
    jaleco_vestido       = bool(ini_read_real("quests", "jaleco_vestido", 0));
    tablet_recebido      = bool(ini_read_real("quests", "tablet_recebido",0));

    saldo_moedas = ini_read_real("jogador", "moedas", 0);

    var saved_room = ini_read_string("jogador", "room", room_get_name(rm_inicio));
    load_x = ini_read_real("jogador", "x", 0);
    load_y = ini_read_real("jogador", "y", 0);

    inventario = [];
    var total = ini_read_real("inventario", "total", 0);
    for (var i = 0; i < total; i++) {
        array_push(inventario, ini_read_string("inventario", "item_" + string(i), ""));
    }

    ini_close();


    if instance_exists(Obj_player) {
        Obj_player.sprite_index = jaleco_vestido
            ? spr_player_idle_com_jaleco
            : spr_jogador_idle_sem_jaleco;
    }


    var room_alvo = asset_get_index(saved_room);
    if room_alvo == room {
        
        if instance_exists(Obj_player) {
            Obj_player.x = load_x;
            Obj_player.y = load_y;
            load_x = 0;
            load_y = 0;
        }
    } else {
        
        porta_destino_pendente = "__load__";
        room_goto(room_alvo);
    }
}






quest_overlay_ativa = -1; 




p2_fase = 0;
p2_resposta_selecionada = -1;
p2_resposta_correta     = 2;
p2_mostrar_tutor        = false;
p2_botoes_criados       = false;


p3_fase = 0; 
p3_texto_atual          = "";
p3_char_index           = 0;
p3_timer_digitar        = 0;
p3_digitacao_completa   = false;
p3_itens_selecionados   = 0;
p3_acertou              = false;
p3_itens_criados        = false;


spr_prontuario_overlay = spr_fundo_prontuario;
spr_colega_overlay     = spr_eliza_dialogo;


p2_dia_titulo[0] = "Relatório Diário — Segunda-feira";
p2_dia_titulo[1] = "Relatório Diário — Terça-feira";
p2_dia_titulo[2] = "Relatório Diário — Quarta-feira  ← HOJE";
p2_registros[0]  = ["10:00  Banho realizado. Cooperativo.",
                     "11:00  PA: 120x80 mmHg.",
                     "11:30  Lanche: Suco e Bolacha.",
                     "12:30  Almoço: Ingesta 50%.  ⚠ Agitado."];
p2_registros[1]  = ["10:30  Banho de leito. Resistente.",
                     "11:30  PA: 130x85 mmHg.",
                     "11:45  Lanche: Água e Fruta.",
                     "12:30  Almoço: Ingesta 80%.  Calmo."];
p2_registros[2]  = ["10:15  Banho realizado. Cooperativo.",
                     "11:15  PA: [Aguardando aferição].",
                     "11:30  Lanche: Suco e Bolacha.",
                     "12:30  Almoço: Ingesta 40%.  ⚠ Agitado."];
p2_opcoes[0] = "A)  A hora do banho.";
p2_opcoes[1] = "B)  O valor da Pressão Arterial.";
p2_opcoes[2] = "C)  A composição do lanche da manhã (presença de açúcar/suco industrializado).";
p2_opcoes[3] = "D)  O nível de ingesta no almoço.";
p2_texto_tutor = "Excelente análise! Muitos cuidadores acham que a agitação de um paciente\ncom demência é aleatória. No entanto, o prontuário muitas vezes esconde\npadrões que mostram gatilhos visíveis — como a ingesta de certos alimentos.\n\nIdentificar esses padrões permite ajustes clínicos que melhoram\ndrasticamente a qualidade de vida.\n\nIsso é o Reconhecimento de Padrões aplicado à análise clínica.";


p3_relato = "Nossa, tô morta! O plantão hoje foi uma loucura. A filha do Seu João veio visitar e trouxe um bolo de laranja maravilhoso, comemos um pedaço na copa. Ela tava super estressada reclamando do trânsito.\n\nAh, sobre o Seu João: hoje de manhã, lá pelas 9h, ele teve um episódio de tosse bem seca. A novela da tarde tava ótima, ele até assistiu um pedaço comigo.\n\nMas olha, fica de olho: desde o almoço a urina dele na sonda está bem escura e com um cheiro forte, e eu não tive tempo de anotar no sistema. A cama dele também tá rangendo do lado esquerdo.\n\nBom plantão pra você!";
p3_textos_itens[0] = "Filha relatou estresse com o trânsito durante a visita.";
p3_textos_itens[1] = "Paciente apresentou tosse seca no período da manhã (9h).";
p3_textos_itens[2] = "Cama do paciente precisa de manutenção (rangendo).";
p3_textos_itens[3] = "Urina concentrada (escura) e com odor forte desde o almoço.";
p3_textos_itens[4] = "Paciente comeu bolo de laranja trazido pela família.";
p3_textos_itens[5] = "Paciente assistiu à televisão no período da tarde.";
p3_itens_corretos[0] = false;
p3_itens_corretos[1] = true;
p3_itens_corretos[2] = false;
p3_itens_corretos[3] = true;
p3_itens_corretos[4] = false;
p3_itens_corretos[5] = false;
p3_itens_sel[0] = false;
p3_itens_sel[1] = false;
p3_itens_sel[2] = false;
p3_itens_sel[3] = false;
p3_itens_sel[4] = false;
p3_itens_sel[5] = false;
p3_texto_tutor = "Saber ouvir é fundamental, mas saber o que registrar salva vidas.\n\nA abstração é a sua capacidade de ignorar as distrações — como a novela\nou o cansaço do colega — e extrair apenas a essência do problema:\nos sintomas (tosse e alteração na urina).\n\nSem abstração, o prontuário vira um diário confuso.\nCom ela, vira um instrumento médico preciso.";


function abrir_quest(_indice) {
    // Não abre se já foi concluída
    if _indice < 4 && quest_completa[_indice] exit;

    quest_overlay_ativa = _indice;
    pausado = false;
    tablet_aberto = false;

    if _indice == 1 {
        p2_fase = 0;
        p2_resposta_selecionada = -1;
        p2_mostrar_tutor = false;
    }

    if _indice == 2 {
        p3_fase = 0;
        p3_texto_atual = "";
        p3_char_index = 0;
        p3_timer_digitar = 0;
        p3_digitacao_completa = false;
        p3_itens_selecionados = 0;
        p3_acertou = false;
        for (var i = 0; i < 6; i++) {
            p3_itens_sel[i] = false;
        }
    }
}

function fechar_quest_overlay() {
    quest_overlay_ativa = -1;
}


function quest_disponivel(_indice) {
    if _indice == 0 { return true; }
    return quest_completa[_indice - 1];
}

// Quest do idoso só disponível após as 4 quests + avaliação final
function quest_idoso_disponivel() {
    var todas = true;
    var i = 0;
    repeat (4) {
        if !quest_completa[i] { todas = false; }
        i++;
    }
    return todas && integradora_completa;
}