function scr_textos(){
	
	switch(npc_nome)
	{
		case "Thats is my granny she get hit by a bazooka":
			texto[0] = "Olá! Eu sou o primeiro NPC que criaste.";
			texto[1] = "Este sistema de array permite que eu fale várias coisas.";
			texto[2] = "Basta clicar com o mouse para passar para a próxima frase!";
		break;
		
		case "guarda":
			texto[0] = "Pare aí! Você não tem permissão para passar.";
			texto[1] = "Traga-me uma poção primeiro.";
		break;
		
		case "vendedor":
			texto[0] = "Tenho as melhores mercadorias da região.";
		break;
	}
}