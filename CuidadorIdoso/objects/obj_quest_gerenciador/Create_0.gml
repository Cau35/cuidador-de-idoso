porta_destino_pendente = "";
load_x = 0;
load_y = 0;


jaleco_vestido = false;






if instance_number(obj_quest_gerenciador) > 1 {
    instance_destroy();
    exit;
}
persistent = true;

// === PROGRESSO DAS 4 QUESTS ===
quest_completa[0] = false; // Estação 1 — Decomposição
quest_completa[1] = false; // Estação 2 — Reconhecimento de Padrões
quest_completa[2] = false; // Estação 3 — Abstração
quest_completa[3] = false; // Estação 4 — Criação de Algoritmos

quest_nome[0] = "Decomposição";
quest_nome[1] = "Reconhecimento de Padrões";
quest_nome[2] = "Abstração";
quest_nome[3] = "Criação de Algoritmos";

integradora_completa = false;
tablet_recebido = false;

// === INVENTÁRIO / OBJETIVOS (dados do tablet) ===
inventario = [];
objetivos = ["Visitar os 4 professores na sala de informática"];

mensagens = [
    { remetente: "Professora Coordenadora",
      texto: "Bem-vinda à formação! Visite os 4 professores na sala de informática para aprender as bases do pensamento computacional." }
];

saldo_moedas = 0;

// === ESTADO DO TABLET (overlay) ===
tablet_aberto = false;
tablet_aba = 0; // 0=Objetivos, 1=Mensagens, 2=Inventário, 3=Conta

// === HUD ===
hud_npc_perto = false;
hud_npc_nome  = "";
hud_npc_perto_proximo_frame = false;
hud_npc_nome_proximo_frame  = "";
hud_moeda_anim = 0;
spr_icone_moeda = noone; 

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



save_file = working_directory + "save01.ini";
save_slot_existe = file_exists(save_file);
function salvar_jogo() {
    ini_open(save_file);

    // Quests
    ini_write_real("quests", "quest_0", quest_completa[0]);
    ini_write_real("quests", "quest_1", quest_completa[1]);
    ini_write_real("quests", "quest_2", quest_completa[2]);
    ini_write_real("quests", "quest_3", quest_completa[3]);
    ini_write_real("quests", "integradora", integradora_completa);
    ini_write_real("quests", "jaleco_vestido", jaleco_vestido);
    ini_write_real("quests", "tablet_recebido", tablet_recebido);

    // Moedas
    ini_write_real("jogador", "moedas", saldo_moedas);

    // Posição do jogador
    if instance_exists(Obj_player) {
        ini_write_real("jogador", "x", Obj_player.x);
        ini_write_real("jogador", "y", Obj_player.y);
        ini_write_string("jogador", "room", room_get_name(room));
    }

    // Inventário (salva cada item como "item_0", "item_1"...)
    ini_write_real("inventario", "total", array_length(inventario));
    for (var i = 0; i < array_length(inventario); i++) {
        ini_write_string("inventario", "item_" + string(i), inventario[i]);
    }

    ini_close();
    save_slot_existe = true;
    show_debug_message("Jogo salvo com sucesso.");
}

function carregar_jogo() {
    if !file_exists(save_file) exit;

    ini_open(save_file);

    // Quests
    quest_completa[0] = bool(ini_read_real("quests", "quest_0", 0));
    quest_completa[1] = bool(ini_read_real("quests", "quest_1", 0));
    quest_completa[2] = bool(ini_read_real("quests", "quest_2", 0));
    quest_completa[3] = bool(ini_read_real("quests", "quest_3", 0));
    integradora_completa = bool(ini_read_real("quests", "integradora", 0));
    jaleco_vestido       = bool(ini_read_real("quests", "jaleco_vestido", 0));
    tablet_recebido      = bool(ini_read_real("quests", "tablet_recebido", 0));

    // Moedas
    saldo_moedas = ini_read_real("jogador", "moedas", 0);

    // Posição + room do jogador
    var saved_room = ini_read_string("jogador", "room", room_get_name(rm_inicio));
    var saved_x    = ini_read_real("jogador", "x", 0);
    var saved_y    = ini_read_real("jogador", "y", 0);

    // Inventário
    inventario = [];
    var total = ini_read_real("inventario", "total", 0);
    for (var i = 0; i < total; i++) {
        array_push(inventario, ini_read_string("inventario", "item_" + string(i), ""));
    }

    ini_close();

    // Vai para a room salva e repositiciona o jogador
    porta_destino_pendente = "__load__"; // flag especial para reposicionamento por load
    load_x = saved_x;
    load_y = saved_y;
    room_goto(asset_get_index(saved_room));
}