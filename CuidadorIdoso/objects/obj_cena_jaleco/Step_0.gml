// A detecção de proximidade + tecla E do obj_npc pai continua rodando normalmente
// (herdada via event_inherited no Create), mas só dispara iniciar_interacao()
// quando o jogador NÃO está em diálogo — adicionamos essa trava abaixo.

if dialogo_ativo {
    // === EFEITO DE DIGITAÇÃO DA LINHA ATUAL ===
	// Detecta clique OU tecla E
var avancar = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"));

if avancar {
    if !digitacao_completa {
        // Pula a digitação
        texto_atual = falas[linha_atual].texto;
        char_index = string_length(falas[linha_atual].texto);
        digitacao_completa = true;

    } else if linha_atual == num_falas - 1 && !mostrar_entrega_jaleco {
        // Última fala — dispara animação de entrega
        mostrar_entrega_jaleco = true;
        entrega_timer = 0;
        array_push(obj_quest_gerenciador.inventario, "Jaleco");
        obj_quest_gerenciador.objetivos[0] = "Ir até a sala de informática e conversar com os 4 professores";
        obj_quest_gerenciador.nova_mensagem("Professora Coordenadora",
            "Vista o jaleco com orgulho. Agora vá até a sala de informática.");
        Obj_player.sprite_index = spr_player_idle_com_jaleco;
        obj_quest_gerenciador.jaleco_vestido = true;

    } else if linha_atual == num_falas - 1 && mostrar_entrega_jaleco {
        // Encerra o diálogo
        dialogo_ativo = false;
        ja_jogou_cena = true;

    } else {
        // Avança para a próxima fala
        linha_atual++;
        iniciar_linha();
    }
}
    if !digitacao_completa {
        var texto_completo = falas[linha_atual].texto;
        timer_digitar++;
        if timer_digitar >= velocidade {
            timer_digitar = 0;
            repeat (velocidade) {
                if char_index < string_length(texto_completo) {
                    char_index++;
                    texto_atual = string_copy(texto_completo, 1, char_index);
                } else {
                    digitacao_completa = true;
                    break;
                }
            }
        }
    }

  
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) && !digitacao_completa {
        texto_atual = falas[linha_atual].texto;
        char_index = string_length(falas[linha_atual].texto);
        digitacao_completa = true;
    }


    if mostrar_entrega_jaleco {
        entrega_timer++;
    }
}
// Versão sobrescrita do Step do obj_npc, adaptada para não interagir durante o diálogo
if !dialogo_ativo {
    var dist = point_distance(x, y, Obj_player.x, Obj_player.y);

    if dist <= raio_interacao {
        obj_quest_gerenciador.set_npc_proximo(nome_npc);

        if keyboard_check_pressed(ord("E")) {
            iniciar_interacao();
			// === DENTRO DO BLOCO "if dialogo_ativo {" que já existe no Step Event ===

// Detecta clique usando coordenadas do GUI (não da room)
if mouse_check_button_pressed(mb_left) {
    var gx = display_mouse_get_x(); // posição X do mouse na tela GUI
    var gy = display_mouse_get_y(); // posição Y do mouse na tela GUI

    if !digitacao_completa {
        // Pula a digitação
        texto_atual = falas[linha_atual].texto;
        char_index = string_length(falas[linha_atual].texto);
        digitacao_completa = true;

    } else if linha_atual == num_falas - 1 && !mostrar_entrega_jaleco {
        // Última fala — dispara animação de entrega
        mostrar_entrega_jaleco = true;
        entrega_timer = 0;
        array_push(obj_quest_gerenciador.inventario, "Jaleco");
        obj_quest_gerenciador.objetivos[0] = "Ir até a sala de informática e conversar com os 4 professores";
        obj_quest_gerenciador.nova_mensagem("Professora Coordenadora",
            "Vista o jaleco com orgulho. Agora vá até a sala de informática.");
        Obj_player.sprite_index = spr_player_idle_com_jaleco;
        obj_quest_gerenciador.jaleco_vestido = true;

    } else if linha_atual == num_falas - 1 && mostrar_entrega_jaleco {
        // Encerra o diálogo
        dialogo_ativo = false;
        ja_jogou_cena = true;

    } else {
        // Avança para a próxima fala
        linha_atual++;
        iniciar_linha();
    }
}
        }
    }
}

