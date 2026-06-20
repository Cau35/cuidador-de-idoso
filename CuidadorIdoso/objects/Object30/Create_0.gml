// Lista de cartões: Texto e o ID do grupo correto
cartoes_dados = [
    ["Vestir o jaleco", 1], ["Pegar o crachá", 1],
    ["Levar o caderno", 2], ["Separar caneta", 2], ["Organizar a mochila", 2],
    ["Conferir o endereço", 3], ["Verificar o horário", 3]
];

// Criar instâncias dos cartões na tela de forma embaralhada
for (var i = 0; i < array_length(cartoes_dados); i++) {
    var _inst = instance_create_layer(random_range(100, 400), random_range(100, 300), "Instances", obj_cartao);
    _inst.texto = cartoes_dados[i][0];
    _inst.grupo_correto = cartoes_dados[i][1];
}

// Definição das áreas de destino (caixas)
caixas = [
    {x: 100, y: 500, nome: "Aparência/ID", ID: 1},
    {x: 400, y: 500, nome: "Materiais", ID: 2},
    {x: 700, y: 500, nome: "Planejamento", ID: 3}
];