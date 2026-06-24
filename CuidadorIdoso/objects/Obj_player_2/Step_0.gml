


var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var vel = 4;

if (move_x != 0 || move_y != 0)
{
    var len = point_distance(0, 0, move_x, move_y);

    move_x /= len;
    move_y /= len;

    x += move_x * vel;
    y += move_y * vel;
}



var half_w = sprite_width / 2;
var half_h = sprite_height / 2;

x = clamp(x, half_w, room_width - half_w);
y = clamp(y, half_h, room_height - half_h);