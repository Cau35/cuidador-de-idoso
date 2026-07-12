
// Fase 1 → clique no botão COM MOUSE, E também funciona
if fase == 1 {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var gw = display_get_gui_width();

    var clicou_botao = mouse_check_button_pressed(mb_left)
        && point_in_rectangle(mx, my, gw/2-180, 358, gw/2+180, 402);

    if clicou_botao || keyboard_check_pressed(ord("E")) {
        fase = 2;
    }
}

// Fase 2 → SÓ E avança (mouse não interfere aqui)
if fase == 2 && keyboard_check_pressed(ord("E")) {
    mini_completa[mini_quest_atual] = true;
    obj_quest_gerenciador.ganhar_moedas(10);

    if mini_quest_atual < 2 {
        iniciar_mini_quest(mini_quest_atual + 1);
    } else {
        quest_ativa = false;
        obj_quest_gerenciador.marcar_quest_completa(4);
    }
}

if !quest_ativa exit;
if fase != 0 exit;




var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var num = obter_num_itens();

// Posicoes das 3 categorias (topo da tela)
var cat_gap  = (gw - 3*cat_w) / 4;
var cat_y    = 80;

// =========================================
// SOLTAR ITEM
// =========================================
if item_arrastando != -1 && mouse_check_button_released(mb_left) {
    var solto = false;

    var c = 0;
    repeat (3) {
        var cat_x = cat_gap + c * (cat_w + cat_gap);

        if point_in_rectangle(mx, my, cat_x, cat_y, cat_x+cat_w, cat_y+cat_h) {
            
            var bloqueado = false;
            var b2 = 0;
            repeat (num) {
                if b2 != item_arrastando
                && item_no_cat[b2] == c
                && obter_cat_correta_item(b2) == c {
                    // Tem item correto na mesma cat — permite mais de um por cat
                }
                b2++;
            }

            if !bloqueado {
                // Remove da cat anterior
                var cat_ant = item_no_cat[item_arrastando];

                // Coloca na nova cat
                item_no_cat[item_arrastando] = c;

                // Verifica se correto
                if obter_cat_correta_item(item_arrastando) == c {
                    cat_errado[c] = false;
                    obj_quest_gerenciador.ganhar_moedas(5);
                } else {
                    cat_errado[c] = true;
                }

                solto = true;

                // Verifica conclusao: todos os itens na categoria certa
                var todos = true;
                var b3 = 0;
                repeat (num) {
                    if item_no_cat[b3] == -1
                    || obter_cat_correta_item(b3) != item_no_cat[b3] {
                        todos = false;
                    }
                    b3++;
                }
                if todos {
                    fase = 1;
                    obj_quest_gerenciador.ganhar_moedas(20);
                }
            }
            break;
        }
        c++;
    }

    if !solto {
        item_no_cat[item_arrastando] = -1;
    }

    item_arrastando = -1;
    exit;
}

// =========================================
// INICIAR ARRASTO
// =========================================
if mouse_check_button_pressed(mb_left) && item_arrastando == -1 {
    var b = 0;
    repeat (num) {
        // Nao arrasta item correto
        var esta_correto = (item_no_cat[b] != -1)
                        && (obter_cat_correta_item(b) == item_no_cat[b]);
        if !esta_correto {
            var bx = 0;
            var by = 0;

            if item_no_cat[b] != -1 {
                // Esta numa categoria
                var c_at = item_no_cat[b];
                var cat_x2 = cat_gap + c_at * (cat_w + cat_gap);
                // Posicao dentro da categoria (grade)
                var itens_antes = 0;
                var b4 = 0;
                repeat (b) {
                    if item_no_cat[b4] == c_at { itens_antes++; }
                    b4++;
                }
                bx = cat_x2 + 10 + (itens_antes mod 2) * (item_w + 8);
                by = cat_y + 36 + floor(itens_antes / 2) * (item_h + 8);
            } else {
                // Esta no painel inferior
                var pos = obter_pos_item_orig(b);
                bx = pos.x;
                by = pos.y;
            }

            if point_in_rectangle(mx, my, bx, by, bx+item_w, by+item_h) {
                item_arrastando  = b;
                item_offset_x    = mx - bx;
                item_offset_y    = my - by;

                // Libera a categoria se estava numa
                if item_no_cat[b] != -1 {
                    item_no_cat[b] = -1;
                }
                break;
            }
        }
        b++;
    }
}

// Tecla E para fechar tutor / avancar
if fase == 1 && keyboard_check_pressed(ord("E")) {
    fase = 2;
}

if fase == 2 && keyboard_check_pressed(ord("E")) {
   
    mini_completa[mini_quest_atual] = true;
    obj_quest_gerenciador.ganhar_moedas(10);

   if mini_quest_atual < 2 {
    iniciar_mini_quest(mini_quest_atual + 1);
} else {
    // Todas concluidas -- fecha definitivamente
    quest_ativa = false;
    obj_quest_gerenciador.marcar_quest_completa(4);
    // Impede de reabrir
    obj_quest_gerenciador.quest_idoso_concluida = true;
}}