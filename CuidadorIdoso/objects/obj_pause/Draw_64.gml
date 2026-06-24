if (paused)
{
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    draw_set_alpha(1);

    draw_set_halign(fa_center);

    draw_text(display_get_gui_width()/2, 200, "PAUSADO");

    for (var i = 0; i < array_length(menu_items); i++)
    {
        if (i == menu_index)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);

        draw_text(
            display_get_gui_width()/2,
            280 + i * 40,
            menu_items[i]
        );
    }
}