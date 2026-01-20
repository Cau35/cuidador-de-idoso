if place_meeting(x, y, obj_player) && !instance_exists(obj_warp)
	{
	var insta = instance_create_depth(0, 0, -9999, obj_warp)
	insta.target_x = target_x
	insta.target_y = target_y
	insta.target_rm = target_rm
	}