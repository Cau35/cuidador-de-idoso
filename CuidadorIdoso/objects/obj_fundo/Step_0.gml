if (global.escolhe_player == false) 
{
    image_alpha += 0.02; 

    if (image_alpha >= 1) 
    {
        room_goto(Room6);
    }
}