#region Textos
function scr_textos(){
	// Retrato do PLAYER depende de quem foi escolhido na seleção
	// global.player: 0/1 = cuidador (masc), 2/3 = cuidadora (fem)
	var _p_neutro = (global.player <= 1) ? portrait_phn : portrait_pmn;
	var _p_falando = (global.player <= 1) ? portrait_phf : portrait_pmf;
	var voz_player = snd_voice_1;
	var voz_npc = snd_voice_2;
	
	
	switch(npc_nome)
	{
		case "Vendedor":
		ds_grid_add_text("Olá, como posso te ajudar?", portrait_pmf, 1, "Personagem 2", voz_npc);
		ds_grid_add_text("Oi, estou em busca de alguns intrumentos cientificos, você terai algum ai?", _p_neutro, 0, "Personagem 1", voz_player);
		ds_grid_add_text("Tenho sim, de uma olhada.", portrait_pmf, 1, "Personagem 2", voz_npc);
		add_op("Estetoscópopio (20 moedas).",								"Resposta 1");
		add_op("Luvas (10 moedas).",								"Resposta 2");
		add_op("Touca (5 moedas).",								"Resposta 3");
		add_op("Medidor de Pressão (50 moedas).",								"Resposta 4");
		break;
		case "Resposta 1":
				ds_grid_add_text("Ainda não.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Então vá falar com Acacia e o ler os livros na estante.", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 2":
				ds_grid_add_text("Apenaspeguei meu jaleco.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Então leia os livros na estante.", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 3":
				ds_grid_add_text("Já peguei meu equipamento e li os livros", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Maravilhoso, o nome dele é Sr. Chico, ele está te esperando, se apresse.", portrait_pmf, 1, "Personagem 2", voz_npc);
				ds_grid_add_text("Certo, irei ver ele.", _p_neutro, 0, "Personagem 2", voz_player);
				break;
		
		
		case "Thats is my granny she get hit by a bazooka":
			ds_grid_add_text("A moça te encara...", noone, 0, "", snd_voice_1, "narracao");
			ds_grid_add_text("Olá, tudo bem?.", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Opa, tudo sim.", portrait_pmf, 1, "Personagem 2", voz_npc);
			ds_grid_add_text("Bom, teria uma pergunta.", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Poderia me falar se qual seria meu cliente de hoje?", _p_falando, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Sei sim, mas antes, você ja pegou seu equipamento e o já leu os livros na estante?", portrait_pmf, 1, "Personagem 2", voz_npc);
				add_op("Ainda não.",								"Resposta 1");
				add_op("Apenas peguei meu equipamento.",						"Resposta 2");
				add_op("Já peguei meu equipamento e li os livros",									"Resposta 3");
		break;
				case "Resposta 1":
				ds_grid_add_text("Ainda não.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Então vá falar com Acacia e o ler os livros na estante.", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 2":
				ds_grid_add_text("Apenaspeguei meu jaleco.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Então leia os livros na estante.", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 3":
				ds_grid_add_text("Já peguei meu equipamento e li os livros", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Maravilhoso, o nome dele é Sr. Chico, ele está te esperando, se apresse.", portrait_pmf, 1, "Personagem 2", voz_npc);
				ds_grid_add_text("Certo, irei ver ele.", _p_neutro, 0, "Personagem 2", voz_player);
				break;
		case "Prof":

    // SE JÁ TEM JALECO
    if (global.player == 1 || global.player == 3) {
        ds_grid_add_text(
            "Você já está com o <y>jaleco</y>, vá ler os livros!!!",
            portrait_pmf,
            1,
            "Professora Acácia",
            snd_voice_2,
            0
        );
		ds_grid_add_text("Depois desse aviso você decide sair de perto dela...", noone, 0, "", snd_voice_1, "narracao");
    }
    // SE AINDA NÃO TEM
    else {
        ds_grid_add_text(
            "Olá Frances! Você gostaria de pegar seu <y>jaleco</y> agora?",
            portrait_pmf,
            1,
            "Professora Acácia",
            snd_voice_2,
            0
        );

        add_op("Pegar", "Pegar_Jaleco");
        add_op("Não pegar", "Nao_Pegar");
    }
		break;

				case "Pegar_Jaleco":
				global.pegar_jaleco = true;
			    ds_grid_add_text("Aqui está!", portrait_pmf, 1, "Professora Acácia", voz_npc);
				// Marca que o jogador agora TEM jaleco
		break;


				case "Nao_Pegar":
			    ds_grid_add_text("Okay!! Até mais tarde!!", portrait_pmf, 1, "Professora Acácia", voz_npc);
		break;
		
		
		case "Estante":
    // Narração inicial (sem retrato/nome)
    ds_grid_add_text(
        "Uma estante velha cheia de livros. Alguns parecem úteis, outros só estão aqui pra enfeitar e juntar poeira.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Você puxa alguns títulos e decide o que vai ler:",
        noone, 0, "", snd_voice_2, "narracao"
    );

    // Opções de livros
    add_op("Guia de Estudos (importante)", "Livro_Guia");
    add_op("Pensamento Computacional (resumo)", "Livro_PC");
    add_op("Livro Aleatório", "Livro_Aleatorio");
    add_op("Fechar a estante", "Fechar_Estante");
break;


case "Livro_Guia":
    ds_grid_add_text(
        "GUIA DE ESTUDOS",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "1) Leia com calma.\n\nNão é “passar o olho”. É ler mesmo.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "2) Anote o que você não entendeu.\n\nSe você não anotar, você vai esquecer e fingir que entendeu.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "3) Teste no jogo o que você aprender.\n\nSem aplicar, vira só texto bonito ocupando espaço.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Você fecha o guia e coloca ele de volta na estante.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    add_op("Ler outro livro", "Estante");
    add_op("Sair", "Fechar_Estante");
break;


case "Livro_PC":
    ds_grid_add_text(
        "PENSAMENTO COMPUTACIONAL (resumo)",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "• Decomposição\nQuebrar um problema grande em partes pequenas e tratáveis.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "• Reconhecimento de padrões\nPerceber o que se repete e reaproveitar solução em vez de reinventar a roda.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "• Abstração\nFocar no essencial e ignorar o barulho.\n\nNem tudo precisa virar mecânica.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "• Algoritmo\nUma sequência clara de passos para resolver.\n\nSe não dá pra explicar, não é algoritmo, é fé.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Você sente que isso vai cair na sua mecânica do idoso, gostando você ou não.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    add_op("Ler outro livro", "Estante");
    add_op("Sair", "Fechar_Estante");
break;


case "Livro_Aleatorio":
    ds_grid_add_text(
        "LIVRO ALEATÓRIO",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Você abre um livro qualquer.\n\nEle fala sobre um assunto extremamente específico.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Depois de duas páginas, você percebe que isso não vai te ajudar em absolutamente nada no jogo.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    ds_grid_add_text(
        "Você fecha na hora certa, antes de perder neurônios.",
        noone, 0, "", snd_voice_2, "narracao"
    );

    add_op("Ler outro livro", "Estante");
    add_op("Sair", "Fechar_Estante");
	
break;
	
case "Fechar_Estante":
	 ds_grid_add_text(
        "Depois dessa auta dose de sabedoria literária, você imprudentemente resolve deixar o ouro em formas de livro",
        noone, 0, "", snd_voice_2, "narracao"
    );
	 ds_grid_add_text(
        "...",
        noone, 0, "", snd_voice_2, "narracao"
    );
	 ds_grid_add_text(
        "Aquele livro aleatório não conta...",
        noone, 0, "", snd_voice_2, "narracao"
    );
break;
		
		
		case "Cutscene_1":

    // quando acabar, vai pra Room_1
	global.cutscene_ativa = true;
    global.cutscene_next_room = Room1;

    // Cena 1
    array_push(cutscene_bg_page, spr_teste_cena1)
    ds_grid_add_text("Que paisagem linda (clique na tecla e do seu teclado para prosseguir).", noone, 0, "", snd_voice_2, "narracao");

    // mantém a mesma imagem
	array_push(cutscene_bg_page, spr_teste_cena1)
    ds_grid_add_text("Acho que essa paisagem ja está ficando chata, acho que quero ir pra outro lugar.", noone, 0, "", snd_voice_2, "narracao");

    // troca para Cena 2
    array_push(cutscene_bg_page, spr_teste_cena2)
    ds_grid_add_text("Oxe, que estranho, como eu vim parar nesse lugar.", noone, 0, "", snd_voice_2, "narracao");

    // final
	array_push(cutscene_bg_page, spr_teste_cena2)
    ds_grid_add_text("Será que estou sonhando, então é melhor eu acordar (quando iniciar o jogo use as telcas de seta do seu teclado para se mover).", noone, 0, "", snd_voice_2, "narracao");

break;
		
case "IDOSO":
{
    // ===============================
    // Inicialização global "safe"
    // ===============================
    if (!variable_global_exists("puzzle")) global.puzzle = 0;
    if (!variable_global_exists("puzzle_cd")) global.puzzle_cd = 0;
	if (!variable_global_exists("moedas")) global.moedas = 0;

    // ===============================
    // Cooldown (30s) entre puzzles
    // ===============================
    if (global.puzzle_cd > 0) {
        global.puzzle_cd -= 1;

        ds_grid_add_text("Obrigado por cuidar de mim...", portrait_IN, 0, "Idoso", voz_npc);
        ds_grid_add_text("Daqui a pouco eu falo de novo...", noone, 0, "", noone, "narracao");
        break; // NÃO usa exit aqui
    }

    // ===============================
    // Escolhe qual puzzle roda
    // ===============================
    switch (global.puzzle) {

        // =========================================
        // PUZZLE 1 (global.puzzle == 0) - ÁGUA
        // =========================================
        case 0:
        {
            ds_grid_add_text("Ei... eu tô com sede...", portrait_IF, 0, "Idoso", voz_npc);
            ds_grid_add_text("O que você faz?", noone, 0, "", noone, "narracao");

            add_op("Dar água agora", "p0_agua_certo");
            add_op("Perguntar antes se ele pode beber", "p0_agua_quase");
            add_op("Ignorar / dizer pra esperar", "p0_agua_errado");
        }
        break;

        // =========================================
        // PUZZLE 2 (global.puzzle == 1) - REMÉDIO
        // =========================================
        case 1:
        {
            ds_grid_add_text("Acho que tá na hora do meu remédio...", portrait_IF, 0, "Idoso", voz_npc);
            ds_grid_add_text("Qual é a sequência certa?", noone, 0, "", noone, "narracao");

            add_op("Conferir horário → pegar remédio → dar água → entregar", "p1_remedio_certo");
            add_op("Pegar e entregar logo sem conferir nada", "p1_remedio_errado");
            add_op("Dar água primeiro e depois ver o remédio", "p1_remedio_quase");
        }
        break;

        // =========================================
        // PUZZLE 3 (global.puzzle == 2) - QUARTO
        // =========================================
        case 2:
        {
            ds_grid_add_text("Tá tudo meio bagunçado aqui... isso me deixa nervoso.", portrait_IF, 0, "Idoso", voz_npc);
            ds_grid_add_text("Qual jeito é melhor pra resolver?", noone, 0, "", noone, "narracao");

            add_op("Organizar por partes (lixo → roupas → remédios → cama)", "p2_quarto_certo");
            add_op("Tentar arrumar tudo de uma vez", "p2_quarto_errado");
            add_op("Arrumar só a cama e ignorar o resto", "p2_quarto_errado2");
        }
        break;

        // =========================================
        // PUZZLE 4 (global.puzzle == 3) - CADEIRA
        // =========================================
        case 3:
        {
            ds_grid_add_text("Minha cadeira tá travando... acho que tem algo errado.", portrait_IF, 0, "Idoso", voz_npc);
            ds_grid_add_text("O que você faz primeiro?", noone, 0, "", noone, "narracao");

            add_op("Verificar roda presa / freio ativado", "p3_cadeira_certo");
            add_op("Puxar com força até destravar", "p3_cadeira_errado");
            add_op("Ignorar e deixar assim", "p3_cadeira_errado2");
        }
        break;

        // =========================================
        // FIM (global.puzzle >= 4)
        // =========================================
        default:
        {
            ds_grid_add_text("Você já fez muita coisa por mim...", portrait_IN, 0, "Idoso", voz_npc);
            ds_grid_add_text("Agora é só ir com calma.", noone, 0, "", noone, "narracao");
        }
        break;
    }
}
break;



// =======================================================
// RESPOSTAS DO PUZZLE 1 - ÁGUA
// =======================================================
case "p0_agua_certo":
{
   global.moedas += 10;
    ds_grid_add_text("Obrigado... era isso mesmo.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Você priorizou uma necessidade imediata.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Isso é pensar em prioridade: primeiro o básico.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p0_agua_quase":
{
    ds_grid_add_text("Eu só queria um pouco de água...", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Você checou antes. Também é cuidado.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Aqui era um caso simples: dava pra agir direto.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p0_agua_errado":
{
    ds_grid_add_text("Ah... tá bom...", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Ignorar sede piora o desconforto.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("No cuidado, reconhecer sinais simples é essencial.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;



// =======================================================
// RESPOSTAS DO PUZZLE 2 - REMÉDIO
// =======================================================
case "p1_remedio_certo":
{
    ds_grid_add_text("Boa... é melhor conferir direitinho.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Algoritmo: checar → preparar → executar.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Ordem certa evita erro e deixa o cuidado seguro.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p1_remedio_quase":
{
    ds_grid_add_text("Água ajuda... mas e o horário do remédio?", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Você ajudou, mas faltou checar primeiro.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("No cuidado, ordem importa.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p1_remedio_errado":
{
    ds_grid_add_text("Tem certeza que é agora...? Eu fico com medo de errar.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Dar sem conferir horário/receita é perigoso.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Algoritmo: checar condição antes de agir.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;



// =======================================================
// RESPOSTAS DO PUZZLE 3 - QUARTO
// =======================================================
case "p2_quarto_certo":
{
    ds_grid_add_text("Assim fica bem melhor... obrigado.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Decomposição: resolver por partes deixa mais fácil.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p2_quarto_errado":
{
    ds_grid_add_text("Calma... assim eu me confundo todo.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Tudo de uma vez aumenta erro e estresse.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Decompor em etapas é mais eficiente.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p2_quarto_errado2":
{
    ds_grid_add_text("A cama tá ok... mas o resto ainda incomoda.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Resolver só um pedaço não resolve tudo.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;



// =======================================================
// RESPOSTAS DO PUZZLE 4 - CADEIRA
// =======================================================
case "p3_cadeira_certo":
{
    ds_grid_add_text("Isso... era o freio mesmo.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("✅ Identificar a causa antes evita piorar.", noone, 0, "", noone, "narracao");
    ds_grid_add_text("Abstração: focar no essencial primeiro.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p3_cadeira_errado":
{
    ds_grid_add_text("Ei, cuidado! Assim pode me machucar.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Forçar pode causar acidente. Verifica antes.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

case "p3_cadeira_errado2":
{
    ds_grid_add_text("Assim eu fico preso... melhor olhar isso.", portrait_IN, 0, "Idoso", voz_npc);
    ds_grid_add_text("❌ Ignorar mantém o problema e pode piorar.", noone, 0, "", noone, "narracao");
    puzzle_finish();
}
break;

function puzzle_finish() {
    global.puzzle += 1;
    global.puzzle_cd = game_get_speed(gamespeed_fps) * 30; // 30 segundos
}
		
	}
}

#endregion
#region ds_grid_add_row
function ds_grid_add_row(){
	///@arg ds_grid
	
	var _grid = argument[0];
	ds_grid_resize(_grid, ds_grid_width(_grid), ds_grid_height(_grid)+ 1);
	return(ds_grid_height(_grid)-1);
}
#endregion
#region ds_grid_add_text
function ds_grid_add_text(){
	///@arg texto
	///@arg retrato
	///@arg lado
	///@arg nome
	///@arg voz
	///@arg tipo (opcional) "dialogo" / "narracao"
	
	var _grid = texto_grid;
	var _y = ds_grid_add_row(_grid);
	
	_grid[# 0, _y] = argument[0];
	_grid[# 1, _y] = argument[1];
	_grid[# 2, _y] = argument[2];
	_grid[# 3, _y] = argument[3];
	_grid[# 4, _y] = argument[4];

	// Tipo opcional
	if (argument_count > 5) {
		_grid[# Infos.Tipo, _y] = argument[5];
	}else{
		_grid[# Infos.Tipo, _y] = "dialogo";
	}
}
#endregion
#region add_op
function add_op(_texto, _resposta){
	op[op_num] = _texto;
	op_resposta[op_num] = _resposta;
	
	op_num++;
}
#endregion