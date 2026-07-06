show_debug_message("bloco 1");

spr_quarto = Spr_QuartoIdoso;

fase = 0;
todos_corretos = false;

ordem_correta[0] = 3;
ordem_correta[1] = 4;
ordem_correta[2] = 0;
ordem_correta[3] = 1;
ordem_correta[4] = 2;



num_slots = 5;

slot_conteudo = array_create(num_slots, -1);
slot_correto = array_create(num_slots, false);
slot_errado = array_create(num_slots, false);

passo_rotulo = [
    "Preparar paciente",
    "..."
];

dica_slot = array_create(num_slots, "");
slot_x = 780;
slot_y_inicio = 108;
slot_largura  = 460;
slot_altura   = 88;
slot_gap      = 12;


function criar_blocos() {
	var textos = []
    textos[0] = "Travar as rodas da cama e da cadeira de rodas.";
    textos[1] = " Sentar a paciente na beira da cama e aguardar alguns segundos.";
    textos[2] = "Realizar a transferência apoiando a paciente com firmeza.";
    textos[3] = " Explicar para Dona Sílvia o procedimento que será realizado.";
    textos[4] = "  Posicionar a cadeira de rodas paralela à cama.";

	var pos_x = [60, 60, 60, 60, 60]; var pos_y = [160, 280, 400,520, 640];
   

    for (var i = 0; i < 5; i++) {
        var b = instance_create_layer(pos_x[i], pos_y[i], "Instances", obj_pop_bloco);
        b.indice       = i;
        b.texto_bloco  = textos[i];
        b.largura      = 660;
        b.altura       = 80;
        b.pos_origem_x = pos_x[i];
        b.pos_origem_y = pos_y[i];
        b.gerenciador  = id;
        b.no_slot      = -1;
    }
}

function verificar_conclusao() {
    var total_certos = 0;
    for (var i = 0; i < num_slots; i++) {
        if slot_correto[i] total_certos++;
    }
    if total_certos == num_slots {
        todos_corretos = true;
        fase = 1;
        obj_quest_gerenciador.ganhar_moedas(20); // bônus de conclusão
    }
}


passo_rotulo[0] = "Passo 1 — Comunicação";
passo_rotulo[1] = "Passo 2 — Logística";
passo_rotulo[2] = "Passo 3 — Segurança Física";
passo_rotulo[3] = "Passo 4 — Prevenção Fisiológica";
passo_rotulo[4] = "Passo 5 — Execução";

dica_slot[0] = "Dica: O que vem antes de qualquer toque?";
dica_slot[1] = "Dica: A ferramenta precisa estar posicionada primeiro.";
dica_slot[2] = "Dica: Qual condição física precisa ser garantida antes de mover?";
dica_slot[3] = "Dica: Dona Sílvia tem tontura. O que previne a queda?";
dica_slot[4] = "Dica: Só agora é seguro realizar o movimento.";

texto_tutor = "Excelente! Você executou o Procedimento Operacional Padrão corretamente...";


criar_blocos();
