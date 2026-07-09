// Protecao
if !variable_instance_exists(id, "fase") exit;

// Tecla E para avancar fases
if fase == 1 && keyboard_check_pressed(ord("E")) {
    fase = 2;
}

if fase == 2 && keyboard_check_pressed(ord("E")) {
    obj_quest_gerenciador.marcar_quest_completa(3);
    room_goto(rm_sala_informatica);
}

// So processa arrasto na fase 0
if fase != 0 exit;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var sx     = 760;
var sy_ini = 128;
var sw     = display_get_gui_width() - sx - 44;
var sh     = 88;
var sgap   = 10;

// -------------------------------------------------------
// SOLTAR BLOCO
// -------------------------------------------------------
if bloco_arrastando != -1 && mouse_check_button_released(mb_left) {

    var solto = false;
    var s = 0;
    repeat (5) {
        var sy = sy_ini + s * (sh + sgap);

        if point_in_rectangle(mx, my, sx, sy, sx + sw, sy + sh) {

            // Verifica se slot ja tem bloco correto
            var slot_bloqueado = false;
            var b2 = 0;
            repeat (5) {
                if b2 != bloco_arrastando && bloco_no_slot[b2] == s && slot_correto[s] {
                    slot_bloqueado = true;
                }
                b2++;
            }

            if !slot_bloqueado {
                // Remove do slot anterior
                var s_anterior = bloco_no_slot[bloco_arrastando];
                if s_anterior != -1 {
                    slot_correto[s_anterior] = false;
                    slot_errado[s_anterior]  = false;
                }

                // Coloca no novo slot
                bloco_no_slot[bloco_arrastando] = s;

                if ordem_correta[s] == bloco_arrastando {
                    slot_correto[s] = true;
                    slot_errado[s]  = false;
                    obj_quest_gerenciador.ganhar_moedas(5);
                } else {
                    slot_correto[s] = false;
                    slot_errado[s]  = true;
                }

                solto = true;

                // Verifica conclusao
                var todos_corretos = true;
                var sc = 0;
                repeat (5) {
                    if !slot_correto[sc] { todos_corretos = false; }
                    sc++;
                }
                if todos_corretos {
                    fase = 1;
                    obj_quest_gerenciador.ganhar_moedas(20);
                }
            }
        }
        s++;
    }

    if !solto {
        // Devolve ao painel
        var s_ant2 = bloco_no_slot[bloco_arrastando];
        if s_ant2 != -1 {
            slot_correto[s_ant2] = false;
            slot_errado[s_ant2]  = false;
        }
        bloco_no_slot[bloco_arrastando] = -1;
    }

    bloco_arrastando = -1;
    exit;
}

// -------------------------------------------------------
// INICIAR ARRASTO
// -------------------------------------------------------
if mouse_check_button_pressed(mb_left) && bloco_arrastando == -1 {

    var b = 0;
    repeat (5) {
        // Nao arrasta bloco em slot correto
        var pode_arrastar = true;
        if bloco_no_slot[b] != -1 && slot_correto[bloco_no_slot[b]] {
            pode_arrastar = false;
        }

        if pode_arrastar {
            var bx = 0;
            var by = 0;

            if bloco_no_slot[b] != -1 {
                var s_at = bloco_no_slot[b];
                bx = sx + 2;
                by = sy_ini + s_at * (sh + sgap) + 2;
            } else {
                bx = bloco_orig_x[b];
                by = bloco_orig_y[b];
            }

            if point_in_rectangle(mx, my, bx, by, bx + bloco_w, by + bloco_h) {
                bloco_arrastando = b;
                bloco_offset_x   = mx - bx;
                bloco_offset_y   = my - by;
            }
        }
        b++;
    }
}