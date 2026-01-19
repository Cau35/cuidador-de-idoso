/// scr_draw_text_color_ext
/// draw_text_color_ext(x, y, texto, line_sep, max_w)
/// Tags: <r> </r> <y> </y> <w> </w>
/// Quebra por "tokens" (palavras e espaços) respeitando max_w

function draw_text_color_ext(_x, _y, _texto, _line_sep, _max_w)
{
    var cx = _x;
    var cy = _y;

    var col = c_white;

    // buffer atual (token)
    var token = "";

    // função "flush" inline (sem função interna): desenha token e limpa
    // (a gente repete o bloco quando precisar)
    var i = 1;
    var n = string_length(_texto);

    while (i <= n)
    {
        var ch = string_copy(_texto, i, 1);

        // quebra de linha manual
        if (ch == "\n")
        {
            // FLUSH token
            if (token != "")
            {
                var w = string_width(token);
                if (cx != _x && (cx + w) > (_x + _max_w)) {
                    cx = _x;
                    cy += _line_sep;
                }
                draw_set_color(col);
                draw_text(cx, cy, token);
                cx += w;
                token = "";
            }

            cx = _x;
            cy += _line_sep;
            i++;
            continue;
        }

        // tenta ler tag
        if (ch == "<")
        {
            var j = i;
            while (j <= n && string_copy(_texto, j, 1) != ">") j++;

            if (j <= n)
            {
                // FLUSH token antes da tag
                if (token != "")
                {
                    var w2 = string_width(token);
                    if (cx != _x && (cx + w2) > (_x + _max_w)) {
                        cx = _x;
                        cy += _line_sep;
                    }
                    draw_set_color(col);
                    draw_text(cx, cy, token);
                    cx += w2;
                    token = "";
                }

                var tag = string_copy(_texto, i, j - i + 1);

                switch (tag)
                {
                    case "<r>":  col = c_red;    break;
                    case "</r>": col = c_white;  break;

                    case "<y>":  col = c_yellow; break;
                    case "</y>": col = c_white;  break;

                    case "<w>":
                    case "</w>": col = c_white;  break;

                    default:
                        // tag desconhecida: desenha literal como texto
                        token = tag;

                        var w3 = string_width(token);
                        if (cx != _x && (cx + w3) > (_x + _max_w)) {
                            cx = _x;
                            cy += _line_sep;
                        }
                        draw_set_color(col);
                        draw_text(cx, cy, token);
                        cx += w3;
                        token = "";
                        break;
                }

                i = j + 1;
                continue;
            }
        }

        // espaço: trata como token separado pra quebrar linha corretamente
        if (ch == " ")
        {
            // FLUSH token (palavra)
            if (token != "")
            {
                var w4 = string_width(token);
                if (cx != _x && (cx + w4) > (_x + _max_w)) {
                    cx = _x;
                    cy += _line_sep;
                }
                draw_set_color(col);
                draw_text(cx, cy, token);
                cx += w4;
                token = "";
            }

            // desenha o espaço como token
            token = " ";
            var w5 = string_width(token);
            if (cx != _x && (cx + w5) > (_x + _max_w)) {
                cx = _x;
                cy += _line_sep;
            }
            draw_set_color(col);
            draw_text(cx, cy, token);
            cx += w5;
            token = "";

            i++;
            continue;
        }

        // char normal: acumula
        token += ch;
        i++;
    }

    // FLUSH final
    if (token != "")
    {
        var w6 = string_width(token);
        if (cx != _x && (cx + w6) > (_x + _max_w)) {
            cx = _x;
            cy += _line_sep;
        }
        draw_set_color(col);
        draw_text(cx, cy, token);
        cx += w6;
        token = "";
    }

    draw_set_color(c_white);
}