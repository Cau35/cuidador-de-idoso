if (arrastando == true) {
    // 1. Soltou o botão, para de arrastar
    arrastando = false; 

    // 2. Verifica se a posição atual colide com a caixa vazia da sequência
    var espaco = instance_place(x, y, obj_espaco_vazio);

    // 3. Se tocou na caixa...
    if (espaco != noone) { 
        
        // 4. Verifica se este item é a resposta que a caixa está esperando
        if (object_index == espaco.item_esperado) {
            
            // --- ACERTOU O PADRÃO ---
            show_message("Muito bem! Perceber o que se repete ajuda a prever, comparar e entender melhor as situações. Isso é reconhecimento de padrões.");
            
            // Trava o item no centro da caixa para ficar visualmente bonito
            x = espaco.x;
            y = espaco.y;
            
            // Destrói a caixa vazia, pois ela já foi preenchida
            instance_destroy(espaco);
            
        } else {
            // --- ERROU O PADRÃO ---
            // Volta para o lugar original na parte de baixo da tela
            x = xstart;
            y = ystart;
        }
        
    } else {
        // --- SOLTOU FORA DE QUALQUER LUGAR ---
        // Volta para o lugar original
        x = xstart;
        y = ystart;
    }
}

if (arrastando == true) {
    arrastando = false; 
    var espaco = instance_place(x, y, obj_espaco_vazio);

    if (espaco != noone) { 
        // TOCOU NA CAIXA! Vamos ver quem ele acha que é o certo.
        show_debug_message("Tocou na caixa! O esperado era: " + object_get_name(espaco.item_esperado) + " | Eu sou: " + object_get_name(object_index));
        
        if (object_index == espaco.item_esperado) {
            show_message("Muito bem! Perceber o que se repete...");
            x = espaco.x;
            y = espaco.y;
            instance_destroy(espaco);
        } else {
            x = xstart;
            y = ystart;
        }
    } else {
        // NÃO TOCOU EM NADA!
        show_debug_message("Soltei, mas não encostei em nenhuma caixa vazia.");
        x = xstart;
        y = ystart;
    }
}