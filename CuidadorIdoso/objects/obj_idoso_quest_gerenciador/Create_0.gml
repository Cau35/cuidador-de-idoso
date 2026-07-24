// =========================================
// ESTADO GERAL
// =========================================
quest_ativa      = false;
mini_quest_atual = 0; // 0, 1, 2
mini_completa[0] = false;
mini_completa[1] = false;
mini_completa[2] = false;
fase             = 0; // 0=jogando | 1=feedback | 2=tutor



// Mini-quest 1 — Higiene e Conforto
cat_nomes0[0] = "Conduta Correta";
cat_nomes0[1] = "Conduta Errada";

// Mini-quest 2 — Sinais de Alerta
cat_nomes1[0] = "Lateralização";
cat_nomes1[1] = "Troca de Lençol";

// Mini-quest 3 — Alimentacao e Hidratacao
cat_nomes2[0] = "Recomendado";
cat_nomes2[1] = "Evitar";
cat_nomes2[2] = "Adaptar para o idoso";

// =========================================
// ITENS DE CADA MINI-QUEST
// Cada item: sprite, nome, categoria correta (0, 1 ou 2)
// SUBSTITUA os nomes dos sprites pelos nomes reais no seu projeto
// =========================================

// Mini-quest 1 — 6 itens
mq0_sprites[0] = V1;         // Higiene Pessoal
mq0_sprites[1] = V2;       // Higiene Pessoal
mq0_sprites[2] = V3;  // Higiene Pessoal
mq0_sprites[3] = F1;    // Conforto e Repouso
mq0_sprites[4] = F2;        // Conforto e Repouso
mq0_nomes[0] = "Paciente Alinhado";
mq0_nomes[1] = "Fralda Ajustada";
mq0_nomes[2] = "Lençol Liso";
mq0_nomes[3] = "Fralda com Dobra";
mq0_nomes[4] = "Lençol Enrrugado";
mq0_correto[0] = 0; // Higiene Pessoal
mq0_correto[1] = 0; // Higiene Pessoal
mq0_correto[2] = 0; // Higiene Pessoal
mq0_correto[3] = 1; // Conforto e Repouso
mq0_correto[4] = 1; // Conforto e Repouso
mq0_num_itens  = 5;

// Mini-quest 2 — 6 itens
mq1_sprites[0] = la3;          // Sinal de Alerta
mq1_sprites[1] = la2;   // Sinal de Alerta
mq1_sprites[2] = la1;  // Normal para a idade
mq1_sprites[3] = trle;        // Normal para a idade
mq1_sprites[4] = trle2;    // Ambiente seguro
mq1_sprites[5] = trle3;     // Ambiente seguro
mq1_sprites[6] = trle4;     // Ambiente seguro
mq1_nomes[0] = "Lateralizar o Paciente";
mq1_nomes[1] = "Posicionar Fralda";
mq1_nomes[2] = "Ajustar e Conferir";
mq1_nomes[3] = "Tirar o Lençol";
mq1_nomes[4] = "Ajustar Paciente";
mq1_nomes[5] = "Soltar Lençol";
mq1_nomes[6] = "Esticar e Finalizar";
mq1_correto[0] = 0; // Sinal de Alerta
mq1_correto[1] = 0; // Sinal de Alerta
mq1_correto[2] = 0; // Normal para a idade
mq1_correto[3] = 1; // Normal para a idade
mq1_correto[4] = 1; // Ambiente seguro
mq1_correto[5] = 1; // Ambiente seguro
mq1_correto[6] = 1; // Ambiente seguro
mq1_num_itens  = 7;

// Mini-quest 3 — 6 itens
mq2_sprites[0] = spr_item_agua;           // Recomendado
mq2_sprites[1] = fruta;          // Recomendado
mq2_sprites[2] = refrigerante;   // Evitar
mq2_sprites[3] = sal;            // Evitar
mq2_sprites[4] = comida;    // Adaptar
mq2_sprites[5] = canudo;         // Adaptar
mq2_nomes[0] = "Agua";
mq2_nomes[1] = "Fruta";
mq2_nomes[2] = "Refrigerante";
mq2_nomes[3] = "Sal em excesso";
mq2_nomes[4] = "Comida mole";
mq2_nomes[5] = "Canudo";
mq2_correto[0] = 0; // Recomendado
mq2_correto[1] = 0; // Recomendado
mq2_correto[2] = 1; // Evitar
mq2_correto[3] = 1; // Evitar
mq2_correto[4] = 2; // Adaptar
mq2_correto[5] = 2; // Adaptar
mq2_num_itens  = 6;


tutor_texto[0] = "Muito bem! Higiene pessoal e conforto sao pilares fundamentais do cuidado.\nItens como toalha, sabonete e escova garantem a dignidade do idoso.\nTravesseiro e coberta adequados previnem escaras e garantem um sono reparador.";
tutor_texto[1] = "Excelente! Reconhecer sinais de alerta como quedas e pressao alta e fundamental.\nCabelo branco e uso de bengala sao naturais da idade e nao indicam problema.\nJa tapetes antiderrapantes e grades na cama fazem parte de um ambiente seguro.";
tutor_texto[2] = "Perfeito! Agua e frutas sao sempre recomendados para idosos.\nRefrigerante e sal em excesso devem ser evitados.\nComida mole e canudo sao adaptacoes que garantem seguranca e autonomia.";


item_arrastando = -1;
item_offset_x   = 0;
item_offset_y   = 0;

// Posicoes originais dos itens (linha de baixo, espalhados)
// Sera calculado dinamicamente baseado no numero de itens
item_no_cat = array_create(6, -1); // qual categoria cada item ocupa (-1 = painel)
cat_correto = array_create(6, false); // se o item esta na categoria certa

// Dimensoes dos itens
item_w = 110;
item_h = 110;

// Dimensoes das categorias (slots)
cat_w  = 340;
cat_h  = 200;

// Funcao para iniciar uma mini-quest
function iniciar_mini_quest(_indice) {
    mini_quest_atual = _indice;
    fase = 0;
    item_arrastando = -1;

    var num = obter_num_itens();
    item_no_cat  = array_create(num, -1);
    cat_correto  = array_create(3, false);
    cat_errado   = array_create(3, false);
    itens_na_cat = array_create(3, 0);
}

function obter_num_itens() {
    if mini_quest_atual == 0 { return mq0_num_itens; }
    if mini_quest_atual == 1 { return mq1_num_itens; }
    return mq2_num_itens;
}

function obter_sprite_item(_i) {
    if mini_quest_atual == 0 { return mq0_sprites[_i]; }
    if mini_quest_atual == 1 { return mq1_sprites[_i]; }
    return mq2_sprites[_i];
}

function obter_nome_item(_i) {
    if mini_quest_atual == 0 { return mq0_nomes[_i]; }
    if mini_quest_atual == 1 { return mq1_nomes[_i]; }
    return mq2_nomes[_i];
}

function obter_cat_correta_item(_i) {
    if mini_quest_atual == 0 { return mq0_correto[_i]; }
    if mini_quest_atual == 1 { return mq1_correto[_i]; }
    return mq2_correto[_i];
}

function obter_nome_cat(_c) {
    if mini_quest_atual == 0 { return cat_nomes0[_c]; }
    if mini_quest_atual == 1 { return cat_nomes1[_c]; }
    return cat_nomes2[_c];
}

function obter_pos_item_orig(_i) {
    var gw = display_get_gui_width();
    var num = obter_num_itens();
    var total_w = num * (item_w + 16) - 16;
    var start_x = gw/2 - total_w/2;
    var ix = start_x + _i * (item_w + 16);
    var iy = display_get_gui_height() - item_h - 24;
    return { x: ix, y: iy };
}


cat_errado  = array_create(3, false);
itens_na_cat = array_create(3, 0);
iniciar_mini_quest(0);
quest_ativa = false;