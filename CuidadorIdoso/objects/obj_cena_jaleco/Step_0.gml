event_inherited(); // deteccao de proximidade + tecla E do obj_npc pai

// =========================================
// DIALOGO (jaleco / incentivo)
// =========================================
if dialogo_ativo {
    var texto_completo = obter_fala_texto();

    if !digitacao_completa {
        timer_digitar++;
        if timer_digitar >= velocidade {
            timer_digitar = 0;
            repeat (velocidade) {
                if char_index < string_length(texto_completo) {
                    char_index++;
                    texto_atual = string_copy(texto_completo, 1, char_index);
                } else {
                    digitacao_completa = true;
                }
            }
        }
    }

    var avancar = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"));

    if avancar {
        if !digitacao_completa {
            texto_atual = texto_completo;
            char_index  = string_length(texto_completo);
            digitacao_completa = true;

        } else if modo_dialogo == "jaleco"
               && linha_atual == num_falas_jaleco - 1
               && !mostrar_entrega_jaleco {
            // Ultima fala do jaleco -- dispara entrega
            mostrar_entrega_jaleco = true;
            entrega_timer = 0;

            array_push(obj_quest_gerenciador.inventario, "Jaleco");
            obj_quest_gerenciador.objetivos[0] = "Ir ate a sala de informatica e conversar com os 4 professores";
            obj_quest_gerenciador.nova_mensagem("Professora Coordenadora",
                "Vista o jaleco com orgulho. Agora va ate a sala de informatica.");
            obj_quest_gerenciador.jaleco_vestido = true;
            if instance_exists(Obj_player) {
                Obj_player.sprite_index = spr_player_idle_com_jaleco;
            }

        } else if modo_dialogo == "jaleco"
               && linha_atual == num_falas_jaleco - 1
               && mostrar_entrega_jaleco {
            // Encerra cutscene do jaleco
            dialogo_ativo = false;
            ja_jogou_cena = true;

        } else if modo_dialogo == "incentivo"
               && linha_atual == num_falas_incentivo - 1 {
            // Encerra dialogo de incentivo
            dialogo_ativo = false;

        } else {
            linha_atual++;
            iniciar_linha();
        }
    }
}

// =========================================
// QUIZ -- clique nas alternativas / avancar
// =========================================
if qz_ativo {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // Fase 0 -- selecionar resposta
    if qz_fase == 0 && !qz_resposta_revelada && mouse_check_button_pressed(mb_left) {
        var gw = display_get_gui_width();
        var base_y = 320; var alt_op = 64; var gap = 14;
        var i = 0;
        repeat (4) {
            var oy = base_y + i * (alt_op + gap);
            if point_in_rectangle(mx, my, 140, oy, gw-140, oy+alt_op) {
                qz_resposta_selecionada = i;
                qz_resposta_revelada    = true;
                if i == qz_correta[qz_pergunta_atual] {
                    qz_acertos++;
                    obj_quest_gerenciador.ganhar_moedas(15);
                }
            }
            i++;
        }
    }

    // Avancar pergunta com E ou clique no botao continuar
    if qz_fase == 0 && qz_resposta_revelada {
        var avancar_pergunta = keyboard_check_pressed(ord("E"));
        if !avancar_pergunta && mouse_check_button_pressed(mb_left) {
            var gw2 = display_get_gui_width();
            if point_in_rectangle(mx, my, gw2-260, 612, gw2-100, 654) {
                avancar_pergunta = true;
            }
        }
        if avancar_pergunta {
            qz_pergunta_atual++;
            qz_resposta_selecionada = -1;
            qz_resposta_revelada    = false;
            if qz_pergunta_atual >= qz_num_perguntas {
                qz_fase = 1;
            }
        }
    }

    // Fase 1 -- resultado
    if qz_fase == 1 {
        var avancar_resultado = keyboard_check_pressed(ord("E"));
        if !avancar_resultado && mouse_check_button_pressed(mb_left) {
            var gw3 = display_get_gui_width();
            if point_in_rectangle(mx, my, gw3/2-150, 540, gw3/2+150, 586) {
                avancar_resultado = true;
            }
        }
        if avancar_resultado {
            if qz_acertos >= 3 {
                qz_fase = 2;
                obj_quest_gerenciador.integradora_completa = true;
                obj_quest_gerenciador.dar_tablet();
                obj_quest_gerenciador.ganhar_moedas(50);
            } else {
                qz_pergunta_atual       = 0;
                qz_acertos              = 0;
                qz_resposta_selecionada = -1;
                qz_resposta_revelada    = false;
                qz_fase                 = 0;
            }
        }
    }

    // Fase 2 -- recompensa, fecha o quiz
    if qz_fase == 2 && keyboard_check_pressed(ord("E")) {
        fechar_quiz();
        room_goto(room_quarto_idoso); // proxima etapa do jogo
    }
}