// Estado do jogo: "jogando", "vitoria"
estado = "jogando";

// Texto do Professor e Aprendizagem
texto_professor = "";
texto_aprendizagem = "Decomposição é dividir uma tarefa grande em partes menores para entender melhor o que precisa ser feito.";

// Posições das 3 caixas
caixa_x[1] = 200;
caixa_y[1] = 450;

caixa_x[2] = 500;
caixa_y[2] = 450;

caixa_x[3] = 800;
caixa_y[3] = 450;

// Nomes das caixas para desenhar na tela
caixa_nome[1] = "1. O que vestir/usar";
caixa_nome[2] = "2. Registrar o cuidado";
caixa_nome[3] = "3. Conferir antes de sair";

// Função para verificar se todos os itens obrigatórios estão nas caixas certas
function verificar_vitoria() {
    var total_certos = 0;
    var total_obrigatorios = 13; // 4 + 4 + 5 itens corretos
    
    with(obj_item) {
        if (encaixado && caixa_atual == caixa_correta) {
            total_certos++;
        }
    }
    
    if (total_certos == total_obrigatorios) {
        estado = "vitoria";
        texto_professor = "Percebeu? Preparar uma visita domiciliar parecia uma tarefa grande e confusa. Mas, quando você separou em partes menores — o que vestir, o que levar e o que conferir — ficou muito mais fácil saber por onde começar. Isso é decomposição.";
    }
}

// Criar os itens dinamicamente na tela (área superior interna)
// Sintaxe: criar_item(x, y, frame_da_sprite, caixa_destino_certa)
function criar_item(_x, _y, _subimg, _caixa_certa) {
    var _inst = instance_create_layer(_x, _y, "Instances", obj_item);
    _inst.subimage = _subimg;
    _inst.caixa_correta = _caixa_certa;
}

// Inicializando os itens na tela (posições X e Y espalhadas aleatoriamente ou em grade)
var _startX = 100;
var _startY = 100;
var _espaco = 80;

// Caixa 1 (Vestir) - IDs de 0 a 3
criar_item(_startX + _espaco*0,  _startY, 0, 1); // Jaleco
criar_item(_startX + _espaco*1,  _startY, 1, 1); // Crachá
criar_item(_startX + _espaco*2,  _startY, 2, 1); // Luvas
criar_item(_startX + _espaco*3,  _startY, 3, 1); // Álcool

// Caixa 2 (Registrar) - IDs de 4 a 7
criar_item(_startX + _espaco*4,  _startY, 4, 2); // Caderno
criar_item(_startX + _espaco*5,  _startY, 5, 2); // Caneta
criar_item(_startX + _espaco*6,  _startY, 6, 2); // Ficha
criar_item(_startX + _espaco*7,  _startY, 7, 2); // Lista

// Caixa 3 (Conferir) - IDs de 8 a 12
criar_item(_startX + _espaco*8,  _startY, 8, 3);  // Endereço
criar_item(_startX + _espaco*9,  _startY, 9, 3);  // Horário
criar_item(_startX + _espaco*10, _startY, 10, 3); // Telefone
criar_item(_startX + _espaco*11, _startY, 11, 3); // Celular
criar_item(_startX + _espaco*12, _startY, 12, 3); // Documento

// Distratores (Caixa correta = -1 significa que não vai em nenhuma)
criar_item(_startX + _espaco*2,  _startY + 100, 13, -1); // Escova
criar_item(_startX + _espaco*4,  _startY + 100, 14, -1); // Fone
criar_item(_startX + _espaco*6,  _startY + 100, 15, -1); // Brinquedo
criar_item(_startX + _espaco*8,  _startY + 100, 16, -1); // Garrafa (Opcional)