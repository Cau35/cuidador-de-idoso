// Define em qual fase a estudante está (começa no 0, que é a primeira fase na programação)
global.fase_atual = 0; 

// --- GABARITO DE RESPOSTAS USANDO ARRAYS ---
// Aqui nós listamos qual objeto é a resposta correta para cada fase

// Fase 1: Caderno -> Crachá -> ___ (Resposta: Jaleco)
global.respostas[0] = obj_jaleco; 

// Fase 2: Jaleco -> Caderno -> Jaleco -> ___ (Resposta: Caderno)
global.respostas[1] = obj_caderno; 

// Fase 3 (Mais difícil): Crachá -> Crachá -> Jaleco -> Crachá -> Crachá -> ___ (Resposta: Jaleco)
global.respostas[2] = obj_jaleco;

// Descobre qual item ele deve aceitar com base na fase atual
item_esperado = global.respostas[global.fase_atual];