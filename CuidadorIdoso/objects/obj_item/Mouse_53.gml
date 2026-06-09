// Só executa a lógica se este item específico estava sendo arrastado
if (arrastando == true) {
    
    // O jogador soltou o botão, então paramos de arrastar
    arrastando = false; 

    // place_meeting verifica se a posição atual (x, y) está colidindo com a 'obj_caixa'
    if (place_meeting(x, y, obj_espaco_vazio)) {
        
        // --- AÇÃO DE SUCESSO ---
        // Aqui o item foi solto no lugar certo!
        
        // Exibe uma mensagem no console para testes
        show_debug_message("Item guardado com sucesso!"); 
        
        // Destrói o objeto para simular que ele foi guardado dentro da caixa
        instance_destroy(); 
        
        // Exemplo de como você poderia avançar a quest (remova as barras // para usar):
        // global.itens_guardados += 1;
        
    } else {
        // --- AÇÃO DE FALHA (Opcional) ---
        // Se quiser que o item volte para a posição inicial caso seja solto fora da caixa, 
        // você pode guardar o xstart e ystart no Create e chamá-los aqui.
    }
}