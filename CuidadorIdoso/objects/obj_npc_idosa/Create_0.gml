// --- VARIÁVEIS BÁSICAS ---
raio_interacao = 64;
nome_npc = "Idoso";
room_destino = room_deomposicao_1; // Mude "Room2" para o nome exato da room que você quer abrir!

// --- VARIÁVEIS DE DIÁLOGO ---
dialogo_ativo = false;
texto_atual = "";
digitacao_completa = true;
linha_atual = 0;

// Escreva as falas do seu diálogo aqui
falas = [
    "Olá, isto é um teste, adicione sua fala.",
    "Esta é a segunda frase do diálogo!",
    "Prepare-se para o desafio!"
];

num_falas = array_length(falas);

// --- FUNÇÃO PARA INICIAR O DIÁLOGO ---
iniciar_interacao = function() {
    dialogo_ativo = true;
    linha_atual = 0;
    texto_atual = falas[linha_atual];
};

// --- FUNÇÃO PARA AVANÇAR DIÁLOGO E MUDAR DE ROOM ---
avancar_dialogo = function() {
    if (linha_atual < (num_falas - 1)) {
        // Se ainda tem falas, avança para a próxima
        linha_atual++;
        texto_atual = falas[linha_atual];
    } else {
        // Se chegou na última fala, fecha o diálogo e muda de room
        dialogo_ativo = false;
        
        // Verifica se a room existe antes de tentar ir para ela (evita crash)
        if (room_exists(room_destino)) {
            room_goto(room_destino);
        } else {
            show_debug_message("ERRO: A room de destino não existe!");
        }
    }
};