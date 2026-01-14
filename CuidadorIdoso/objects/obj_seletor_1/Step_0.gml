var _mouse_sobre = position_meeting(mouse_x, mouse_y, id);
var _mouse_click = mouse_check_button_pressed(mb_left);

if (global.escolhe_player) 
{
    // --- LÓGICA DE SELEÇÃO (O QUE ACONTECE ANTES DE CLICAR) ---
    if (_mouse_sobre) 
    {
        image_speed = .6;
        image_alpha = lerp(image_alpha, 1, .1);
        
        if (_mouse_click) 
        {
            global.player = player;         // Guarda QUEM foi o escolhido
            global.escolhe_player = false;  // Fecha a fase de seleção
        }
    }
    else 
    {
        image_speed = lerp(image_speed, 0, .1);
        image_alpha = lerp(image_alpha, 0.5, .1); // Fica meio transparente se não estiver com o mouse em cima
    }
}
else 
{
    // --- LÓGICA DE SUMIÇO (O QUE ACONTECE DEPOIS DO CLIQUE) ---
    
    // Se o MEU número de player for DIFERENTE (!=) do escolhido globalmente
    if (player != global.player) 
    {
        // Eu não fui o escolhido, então eu sumo!
        image_alpha -= 0.05; 
    } 
    else 
    {
        // Eu fui o escolhido, então eu fico bem visível!
        image_alpha = 1;
    }
}