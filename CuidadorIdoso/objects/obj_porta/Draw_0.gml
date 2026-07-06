
draw_self();

if (instance_exists(Obj_player)) {
    var dist = point_distance(x, y, Obj_player.x, Obj_player.y);

    if (dist <= raio_interacao) {
        obj_quest_gerenciador.set_npc_proximo(nome_acao);
	if dist <= raio_interacao {
    draw_set_alpha(10);
    draw_set_color(c_green);
    draw_rectangle(bbox_left - 4, bbox_top - 4, bbox_right + 4, bbox_bottom + 4, false);
    draw_set_alpha(1);
		}
	} 
}

