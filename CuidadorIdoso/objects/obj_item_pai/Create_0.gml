arrastando = false;

// Você também pode aproveitar para gravar a posição inicial aqui!
xstart = x;
ystart = y;

// Define a fase inicial
global.fase_atual = 0; 

// Define qual objeto é a resposta correta para a Fase 0
// Ex: Se a tela mostra [Caderno] -> [Crachá] -> [___], a resposta é Jaleco.
global.respostas[0] = obj_jaleco;