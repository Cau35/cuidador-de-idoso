event_inherited();
nome_npc = "Professora Coordenadora";



function iniciar_interacao() {
    if !obj_quest_gerenciador.quest_completa[0] {
        obj_idoso_quest_gerenciador.quest_ativa = true;
        obj_idoso_quest_gerenciador.iniciar_mini_quest(0);
    }
}