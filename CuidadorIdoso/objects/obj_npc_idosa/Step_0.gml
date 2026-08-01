// 1. Se o diálogo do próprio NPC já estiver aberto, aperta "E" para avançar ou fechar
if (dialogo_ativo) {
    if (keyboard_check_pressed(ord("E"))) {
        avancar_dialogo();
    }
    exit; // Não executa o restante do código enquanto estiver falando
}


// --- CHECAGENS DE OUTROS OBJETOS (SAÍDAS ANTECIPADAS) ---

if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.dialogo_ativo) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.qz_ativo) exit;
if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.pausado) exit;
if (instance_exists(obj_gerenciador) && obj_gerenciador.quest_concluida) exit;
if (instance_exists(obj_gerenciador) && obj_gerenciador.mostrar_fala_professor) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.pre_quiz_ativo) exit;
if (instance_exists(obj_cena_jaleco) && obj_cena_jaleco.tablet_dialogo_ativo) exit;
if (instance_exists(obj_npc_prof_abstracao) && obj_npc_prof_abstracao.dialogo_ativo) exit;
if (instance_exists(obj_npc_prof_algoritmos) && obj_npc_prof_algoritmos.dialogo_ativo) exit;
if (instance_exists(obj_npc_prof_padroes) && obj_npc_prof_padroes.dialogo_ativo) exit;

if (instance_exists(obj_npc_prof_decomposicao)) {
    if (obj_npc_prof_decomposicao.dialogo_ativo) exit;
}

if (instance_exists(obj_idoso_quest_gerenciador)) {
    if (obj_idoso_quest_gerenciador.quest_ativa) exit;
}   

if (instance_exists(obj_quest_gerenciador) && obj_quest_gerenciador.quest_overlay_ativa != -1) exit;

if (variable_instance_exists(id, "indice_quest")) {
    if (obj_quest_gerenciador.quest_completa[indice_quest]) exit;
}


// --- LÓGICA PRINCIPAL DE INTERAÇÃO ---

if (instance_exists(Obj_player)) {
    var dist = point_distance(x, y, Obj_player.x, Obj_player.y);

    if (dist <= raio_interacao) {
        // Verifica se está bloqueado
        var bloqueado = false;
        if (variable_instance_exists(id, "indice_quest")) {
            bloqueado = !obj_quest_gerenciador.quest_disponivel(indice_quest);
        }

        if (bloqueado) {
            obj_quest_gerenciador.set_npc_proximo("[BLOQUEADO]");
        } else {
            obj_quest_gerenciador.set_npc_proximo(nome_npc);

            // Abre o diálogo se o jogador apertar "E" perto do NPC
            if (keyboard_check_pressed(ord("E"))) {
                iniciar_interacao();
            }
        }
    }
}