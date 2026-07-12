// Sprite do quarto
spr_quarto = Spr_QuartoIdoso; // troque pelo nome real

// Estado da quest
fase = 0; // 0=jogando | 1=conclusao | 2=tutor

// Ordem correta dos blocos por slot
// Blocos: 0=A 1=B 2=C 3=D 4=E
// Resposta: slot0=D(3) slot1=E(4) slot2=A(0) slot3=B(1) slot4=C(2)
ordem_correta[0] = 3;
ordem_correta[1] = 4;
ordem_correta[2] = 0;
ordem_correta[3] = 1;
ordem_correta[4] = 2;

// Estado dos slots
slot_correto[0] = false;
slot_correto[1] = false;
slot_correto[2] = false;
slot_correto[3] = false;
slot_correto[4] = false;
slot_errado[0]  = false;
slot_errado[1]  = false;
slot_errado[2]  = false;
slot_errado[3]  = false;
slot_errado[4]  = false;

// Rotulos
passo_rotulo[0] = "Passo 1 - Comunicacao";
passo_rotulo[1] = "Passo 2 - Logistica";
passo_rotulo[2] = "Passo 3 - Seguranca Fisica";
passo_rotulo[3] = "Passo 4 - Prevencao Fisiologica";
passo_rotulo[4] = "Passo 5 - Execucao";

dica_slot[0] = "Dica: O que vem antes de qualquer toque?";
dica_slot[1] = "Dica: A ferramenta precisa estar posicionada primeiro.";
dica_slot[2] = "Dica: Qual condicao fisica precisa ser garantida?";
dica_slot[3] = "Dica: Dona Silvia tem tontura. O que previne a queda?";
dica_slot[4] = "Dica: So agora e seguro realizar o movimento.";

// Textos dos blocos
textos_blocos[0] = "[A] Travar as rodas da cama e da cadeira.";
textos_blocos[1] = "[B] Sentar a paciente na beira e aguardar.";
textos_blocos[2] = "[C] Realizar a transferencia com firmeza.";
textos_blocos[3] = "[D] Explicar o procedimento para Dona Silvia.";
textos_blocos[4] = "[E] Posicionar a cadeira paralela a cama.";

// Qual slot cada bloco ocupa (-1 = painel esquerdo)
bloco_no_slot[0] = -1;
bloco_no_slot[1] = -1;
bloco_no_slot[2] = -1;
bloco_no_slot[3] = -1;
bloco_no_slot[4] = -1;

// Arrasto
bloco_arrastando = -1;
bloco_offset_x   = 0;
bloco_offset_y   = 0;

// Posicoes originais no painel esquerdo
bloco_orig_x[0] = 60;
bloco_orig_x[1] = 60;
bloco_orig_x[2] = 60;
bloco_orig_x[3] = 60;
bloco_orig_x[4] = 60;
bloco_orig_y[0] = 140;
bloco_orig_y[1] = 228;
bloco_orig_y[2] = 316;
bloco_orig_y[3] = 404;
bloco_orig_y[4] = 492;
bloco_w = 620;
bloco_h = 72;

// Texto do tutor
texto_tutor = "Excelente! Voce executou o Procedimento Operacional Padrao corretamente.\n\nCada passo tem uma razao clinica precisa:\n- Comunicar primeiro garante consentimento e preparo psicologico.\n- Posicionar a cadeira antes evita improvissos.\n- Travar as rodas e condicao critica.\n- Aguardar na beira previne a hipotensao ortostatica.\n- So entao a transferencia e executada com seguranca.";