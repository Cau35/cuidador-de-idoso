if mostrar_feedback {
    feedback_timer--;
    if feedback_timer <= 0 {
        mostrar_feedback = false;
        
        verificar_quest_completa();
    }
}