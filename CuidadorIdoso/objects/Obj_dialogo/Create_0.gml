enum Infos{
	Texto,
	Retrato,
	Lado,
	Nome
}


npc_nome = "";
texto_grid = ds_grid_create(4, 0);
pagina = 0;
inicializar = false;

caractere = 0;
alarm[0] = 1;

op[0] = "";             // Guarda o texto das opções
op_resposta[0] = "";    // Guarda para onde cada opção envia o diálogo
op_num = 0;             // Quantidade de opções no texto atual
op_selecionada = 0;     // Qual opção o jogador está a apontar
op_draw = false;        // Controla se as opções devem ser desenhadas
