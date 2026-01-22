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
		case "Thats is my granny she get hit by a bazooka":
			ds_grid_add_text("A moça te encara...", noone, 0, "", snd_voice_1, "narracao");
			ds_grid_add_text("Oi, tudo dboa?.", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Opa eae...", portrait_pmf, 1, "Personagem 2", voz_npc);
			ds_grid_add_text("Eu me sinto meio só ultimamente...", _p_neutro, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Tipo, eu to trabalhando <r>muito</r>, e com pessoas que me enchem o saco", _p_falando, 0, "Personagem 1", voz_player);
			ds_grid_add_text("Sei como é, quer continuar falando sobre isso?", portrait_pmf, 1, "Personagem 2", voz_npc);
				add_op("Não, obrigado",								"Resposta 1");
				add_op("Sim, muito obrigado",						"Resposta 2");
				add_op("Tanto faz",									"Resposta 3");
		break;
				case "Resposta 1":
				ds_grid_add_text("Não, obrigado.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Okay, tchau", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 2":
				ds_grid_add_text("Sim, muito obrigado.", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Foi por educação, se vira ai negão", portrait_pmf, 1, "Personagem 2", voz_npc);
				break;
				case "Resposta 3":
				ds_grid_add_text("Tanto faz", _p_neutro, 0, "Personagem 1", voz_player);
				ds_grid_add_text("Mehhh", portrait_pmf, 1, "Personagem 2", voz_npc);
				ds_grid_add_text("Tchau, desempregada", _p_neutro, 0, "Personagem 1", voz_player);
				break;
				
		case "Prof":

    // SE JÁ TEM JALECO
    if (global.player == 1 || global.player == 3) {
        ds_grid_add_text(
            "Você já está com o <y>jaleco</y>, vaza frances",
            portrait_pmf,
            1,
            "Professora Acácia",
            snd_voice_2,
            0
        );
		ds_grid_add_text("Depois dessa grosseria você decide sair de perto dela...", noone, 0, "", snd_voice_1, "narracao");
    }
    // SE AINDA NÃO TEM
    else {
        ds_grid_add_text(
            "Olá! Você gostaria de pegar seu <y>jaleco</y> agora?",
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
    ds_grid_add_text("Teste um da cutscene", noone, 0, "", snd_voice_2, "narracao");

    // mantém a mesma imagem
	array_push(cutscene_bg_page, spr_teste_cena1)
    ds_grid_add_text("esta imagem vai permanecer até eu pedir para mudar", noone, 0, "", snd_voice_2, "narracao");

    // troca para Cena 2
    array_push(cutscene_bg_page, spr_teste_cena2)
    ds_grid_add_text("Viu só?! mudou!!", noone, 0, "", snd_voice_2, "narracao");

    // final
	array_push(cutscene_bg_page, spr_teste_cena2)
    ds_grid_add_text("e agora o jogo vai começar!!!", noone, 0, "", snd_voice_2, "narracao");

break;
		
		
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