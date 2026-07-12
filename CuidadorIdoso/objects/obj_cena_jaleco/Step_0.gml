event_inherited();

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
            texto_atual        = texto_completo;
            char_index         = string_length(texto_completo);
            digitacao_completa = true;

        } else if modo_dialogo == "jaleco"
               && linha_atual == num_falas_jaleco - 1
               && !mostrar_entrega_jaleco {
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
            dialogo_ativo = false;
            ja_jogou_cena = true;
			obj_quest_gerenciador.cena_jaleco_concluida = true;

        } else if modo_dialogo == "incentivo"
               && linha_atual == num_falas_incentivo - 1 {
            dialogo_ativo = false;

        } else {
            linha_atual++;
            iniciar_linha();
        }
    }
}

// =========================================
// DIALOGO PRE-QUIZ
// =========================================
if pre_quiz_ativo {
    var texto_pq = falas_pre_quiz[pre_quiz_linha].texto;

    if !pre_quiz_digitacao_ok {
        pre_quiz_timer++;
        if pre_quiz_timer >= 1 {
            pre_quiz_timer = 0;
            if pre_quiz_char_index < string_length(texto_pq) {
                pre_quiz_char_index++;
                pre_quiz_texto_atual = string_copy(texto_pq, 1, pre_quiz_char_index);
            } else {
                pre_quiz_digitacao_ok = true;
            }
        }
    }

    var avancar_pq = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"));

    if avancar_pq {
        if !pre_quiz_digitacao_ok {
            pre_quiz_texto_atual  = texto_pq;
            pre_quiz_char_index   = string_length(texto_pq);
            pre_quiz_digitacao_ok = true;
        } else if pre_quiz_linha < num_falas_pre_quiz - 1 {
            pre_quiz_linha++;
            pre_quiz_texto_atual  = "";
            pre_quiz_char_index   = 0;
            pre_quiz_timer        = 0;
            pre_quiz_digitacao_ok = false;
        } else {
            // Falas pre-quiz terminaram -- abre o quiz
            pre_quiz_ativo = false;
            abrir_quiz();
        }
    }
}

// =========================================
// QUIZ
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

    // Avancar pergunta com E ou clique
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
               
                qz_ativo                = false;
                tablet_dialogo_ativo    = true;
                tablet_dialogo_linha    = 0;
                tablet_dialogo_texto    = "";
                tablet_dialogo_char     = 0;
                tablet_dialogo_timer    = 0;
                tablet_dialogo_digit_ok = false;
                mostrar_entrega_tablet  = false;
            } else {
               
                qz_pergunta_atual       = 0;
                qz_acertos              = 0;
                qz_resposta_selecionada = -1;
                qz_resposta_revelada    = false;
                qz_fase                 = 0;
            }
        }
    }
}

// =========================================
// DIALOGO DE ENTREGA DO TABLET
// =========================================
if tablet_dialogo_ativo {
    var texto_tab = falas_tablet[tablet_dialogo_linha].texto;

    if !tablet_dialogo_digit_ok {
        tablet_dialogo_timer++;
        if tablet_dialogo_timer >= 1 {
            tablet_dialogo_timer = 0;
            if tablet_dialogo_char < string_length(texto_tab) {
                tablet_dialogo_char++;
                tablet_dialogo_texto = string_copy(texto_tab, 1, tablet_dialogo_char);
            } else {
                tablet_dialogo_digit_ok = true;
            }
        }
    }

    var avancar_tab = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("E"));

    if avancar_tab {
        if !tablet_dialogo_digit_ok {
            tablet_dialogo_texto    = texto_tab;
            tablet_dialogo_char     = string_length(texto_tab);
            tablet_dialogo_digit_ok = true;
        } else if tablet_dialogo_linha < num_falas_tablet - 1 {
            tablet_dialogo_linha++;
            tablet_dialogo_texto    = "";
            tablet_dialogo_char     = 0;
            tablet_dialogo_timer    = 0;
            tablet_dialogo_digit_ok = false;
        } else {
            // Falas do tablet terminaram -- dispara animacao
            tablet_dialogo_ativo   = false;
            mostrar_entrega_tablet = true;
            tablet_entrega_timer   = 0;

            // Entrega o tablet
            obj_quest_gerenciador.integradora_completa = true;
            obj_quest_gerenciador.dar_tablet();
            obj_quest_gerenciador.ganhar_moedas(50);
        }
    }
}

// =========================================
// ANIMACAO DE ENTREGA DO TABLET
// =========================================
if mostrar_entrega_tablet {
    tablet_entrega_timer++;
    // Aguarda 60 frames antes de aceitar E para nao pular acidentalmente
    if tablet_entrega_timer > 60 && keyboard_check_pressed(ord("E")) {
        mostrar_entrega_tablet = false;
        room_goto(room_quarto_idoso);
    }
}