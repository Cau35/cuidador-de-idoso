event_inherited(); // chama o Create do obj_npc pai

nome_npc = "Professora Coordenadora";

function pode_iniciar_integradora() {
    var todas = true;
    for (var i = 0; i < 4; i++) {
        if !obj_quest_gerenciador.quest_completa[i] { todas = false; break; }
    }
    return todas && !obj_quest_gerenciador.integradora_completa;
}

function iniciar_interacao() {
    if pode_iniciar_integradora() {
        room_goto(rm_quiz_integrador);
    } else if obj_quest_gerenciador.integradora_completa {
        // Já fez tudo — diálogo de reforço/transição
        show_debug_message("Você já concluiu a formação. Siga para a casa do idoso.");
        // room_goto(rm_casa_idoso); // opcional: deixar ela reabrir a transição
    } else {
        // Ainda faltam professores — diálogo de incentivo
        var faltam = "";
        for (var i = 0; i < 4; i++) {
            if !obj_quest_gerenciador.quest_completa[i] {
                faltam += "- " + obj_quest_gerenciador.quest_nome[i] + "\n";
            }
        }
        show_debug_message("Ainda faltam: \n" + faltam);
        // Integre aqui com seu sistema de diálogo/balão de fala
    }
}