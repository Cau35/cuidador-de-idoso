// Step Event do obj_gerenciador
if mostrar_fala_professor {
    if keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space) {
        mostrar_fala_professor = false;
        obj_quest_gerenciador.marcar_quest_completa(0);
        room_goto(rm_sala_informatica);
    }
}
if mostrar_feedback {
    feedback_timer--;
    if feedback_timer <= 0 {
        mostrar_feedback = false;
        
        verificar_quest_completa();
    }
}
