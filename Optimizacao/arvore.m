
% Exemplo de Uso

% Inicializa a árvore com um nó raiz de valor 10
raiz = criarNo(4.62);

raiz = adicionarNoEsquerda(raiz, 1.67);
raiz = adicionarNoDireita(raiz, 2.8);
raiz.esquerda = adicionarNo(raiz.esquerda, 3);





% Arvore Binaria
function no = adicionarNoEsquerda(noPai, valorNovo)
    novoNo = criarNo(valorNovo);
    noPai.esquerda = novoNo;
    no = noPai;
end

function no = adicionarNoDireita(noPai, valorNovo)
    novoNo = criarNo(valorNovo);
    noPai.direita = novoNo;
    no = noPai;
end

function no = criarNo(valor)
    no.valor = valor;
    no.esquerda = [];
    no.direita = [];
end
function no = adicionarNo(noPai, valorNovo)
    novoNo = criarNo(valorNovo);
    
    if isempty(noPai.esquerda)
        noPai.esquerda = novoNo;
    elseif isempty(noPai.direita)
        noPai.direita = novoNo;
    else
        % Ambos os filhos já estão ocupados; escolha um lado para adicionar
        % Aqui, optamos por adicionar à esquerda por padrão
        noPai.esquerda = novoNo;
    end
    
    no = noPai;
end

function no = criarNo(valor)
    no.valor = valor;
    no.esquerda = [];
    no.direita = [];
end
