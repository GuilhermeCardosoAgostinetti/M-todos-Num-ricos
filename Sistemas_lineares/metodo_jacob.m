%------------------------------------
%           Resolução de Sistemas Lineares - Método Jacob / Método de Simpson/
%           Método de Simpson Adaptativo
%------------------------------------------------------------------
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------
%
%       Chamada do Procedimento
%------------------------------
%       I = imt(f,n,a,b); Método dos Trapézios
%    
%       Variaveis de Entrada Método dos Traézios e Método de Simpson
%       
%
%       Variaveis de Método de Simpson Adaptativo
%       f - Função Avaliada
%------------------------------
%       Variaveis de Saida
%       I - Integral Numérica
% 
%------------------------------

clc, clear

%       ----------------
%       Entrada
%-----------------------

epsilon = 10^-3;
A = [10 -1 2 0
    -1 11 -1 3
     2 -1 10 -1
     0 3 -1 8];
 
B = [6; 25; -11; 15];

x_0 = zeros(1,length(A));
R = sistema_jacob(A,B,x_0,epsilon);

function [x_R, camada] = sistema_jacob(A,B,x_0,epsilon)
    camada = 0;
    while true
        camada = camada + 1;
        for i = 1:length(A)
            T = [1:length(A)];
            T(i)= [];
            s = 0;
            for j = T;
                q = (-A(i,j)*x_0(j));
                s = s + q; 
            end
            x_R(i) = (s+B(i,1))/A(i,i);
        end
        norma = abs(x_R-x_0)/abs(x_R);
    
        if norma<epsilon
            disp("Método Bem Sucedido, Atingindo na iteração: "+ camada)
            disp("Solução Numérica: " )
            disp(x_R)
            break
        end
        x_0 = x_R;
    end
end
 
%-----------------------------------------------------------------------
%--------------------------------------------------
%       Guilherme Cardoso Agostinetti
%       Data da última Atualização - 26/08/2023    
%       Mestrando de Matemática Aplicada e Computacional - PGMAC - UEL
%       CCE - UEL
%       e-mail: guilherme.agostinetti@uel.br
%--------------------------------------------------