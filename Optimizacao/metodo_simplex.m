


%%% ALGORITMO MÉTODO SIMPLEX

%------------------------------------
%           Optimização Linear - Método Simplex
%------------------------------------------------------------------
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------
%
%       Chamada do Procedimento
%------------------------------
%       I = spx(A,B,C);
%       
%       Variaveis de Entrada Método dos Traézios e Método de Simpson
%       c - Coeficientes da Função Objetiva
%       B - Coeficientes Restrições
%       b - Termos Livres
%       ITMAX - Máximo de interação
%
%------------------------------
%       Variaveis de Saida
%       X - Solução.
% 
%------------------------------

clc, clear

%       ----------------
%       Entrada
%-----------------------
% 



c = [-3 -2 0 0 0]; % Função Objetiva Forma Padrão
c_n = [3 2 0 0 0]; % Função Objetiva 
B = [0.5 0.3 1 0 0; 
    0.1 0.2 0 1 0;
    0.4 0.5 0 0 1];% Restrições
b = [3;
    1;
    3];
ITMAX = 10;



[x_resultado,LS] = spx(c,c_n,B,b,ITMAX)

function [x_resultado,LS] = spx(c,c_n,B,b,ITMAX)
    
    %       ---------------------------
    %       Inicialização de Variáveis
    %----------------------------------
    
    Xb = []; %Inicia vetor de variáveis básicas.
    Xn = []; %Inicia vetor de variáveis Normais.
    Xbv = [];
    Xnv = [];
    
    
    %       ---------------------------
    %       Gera Matriz Base e Normal
    %----------------------------------
    
    n = length(B(:,1)); % Num de Linhas.
    m = length(B(1,:)); % Num de Colunas.
    
    % Verificando Sistema
    for i = 1:n
        Xb = [Xb B(:,(m-n)+i)];
        Xbv = [Xbv (m-n)+i];
    end
    
    for i = 1:(m-n)
        Xn = [Xn B(:,i)];
        Xnv = [Xnv i];
    end
    
    % Primeira Xb Inversa.
    Xb_inversa = Xb;
    
    %       ---------------------------------
    %                   INICIO MÉTODO
    %---------------------------------------
    
    for l = 1:ITMAX
    
        %       -----------------------------------
        %       PASSO 1: Solução Básica Factível.
        %---------------------------------------
    
        x_f = Xb_inversa*b; %Calcula a solução por operações elementares
        
        %       -----------------------------------
        %       PASSO 2: Calcular custos Relativos.
        %------------------------------------------
        
        %2.1. Vetor Multiplicador Simplex
        for i = 1:n
            c_b(i) = c(Xbv(i));
        end
        
        vetor_lambda = transpose(Xb_inversa)*transpose(c_b);
        
        %2.2. Calculo dos custos relativos
        for i = 1:(m-n)
            c_red(i)  = c(Xnv(i))-transpose(vetor_lambda)*Xn(:,i);
        end
        
        %2.3. Variáveis que entra na base
        t = min(c_red);
        indice_entra = find(c_red == t);
        indice_entra = indice_entra(1);
    
        %       -----------------------------------
        %       PASSO 3: Teste de Otimalidade.
        %------------------------------------------
        
        if t >=0
            disp("Solução Ótima.")
            for i =1:length(x_f)
                disp("X"+ Xbv(i)+ " = "+ x_f(i))
            end
            break
        end
        
        %       -----------------------------------
        %       PASSO 4: Cálculo da Direção simplex.
        %------------------------------------------
        
        d = Xb_inversa*(-Xn(:,indice_entra(1)));
        
        %       -----------------------------------
        %       PASSO 5: Tamanho do Passo.
        %------------------------------------------
        
        for i = 1:length(d)
            if d(i) < 0
                ep(i) = (-x_f(i))/d(i);
            end
        end
        
        r = min(ep);
        indice_sai = find(ep == r);
        indice_sai = indice_sai(1);
    
        %       -----------------------------------
        %       PASSO 6: ATUALIZAÇÃO DA PARTIÇÃO
        %------------------------------------------
        
        aux = Xbv;
        aux(indice_sai) = Xnv(indice_entra);
        Xnv(indice_entra) = Xbv(indice_sai);
        Xbv = aux;
        
        % Reiniciando as matrizes base e normal
        Xb = [];
        Xn = [];
        
        for i = Xbv
            Xb = [Xb B(:,i)];
        end
    
        for i = Xnv
            Xn = [Xn B(:,i)];
        end
    
         % Atualizando B_inversa
         Xb_in = [];
         for i = 1:n
            if indice_sai ~= i
                Xb_in(i,:) = Xb_inversa(i,:) - d(i)/d(indice_sai)*Xb_inversa(indice_sai,:);
            else
                Xb_in(i,:) = -1/d(indice_sai)*Xb_inversa(indice_sai,:);
            end
         end
         
         Xb_inversa = Xb_in;
    end  
   
    x_resultado = zeros([1, m]);
    for i = 1:length(Xbv)
      x_resultado(Xbv(i)) = x_f(i);
    end
    disp(x_resultado)
    %Calcula o valor da Função objetiva

    LS = c_n*transpose(x_resultado);
end



% %EXEMPLO 1
% % c = [-1 -2 0 0]; % Função Objetiva
% % B = [1 1 1 0; 
% %     0 1 0 1 ];% Restrições
% % b = [6;
% %     3];
% % ITMAX = 10;
% 
% % 
% % % EXEMPLO 2
% % 
% c = [-1 -1 0 0 0 ];
% B = [1 1 1 0 0;
%      1 -1 0 1 0;
%      -1 1 0 0 1];
% b = [6;  
%     4;
%      4];
% ITMAX = 10;



