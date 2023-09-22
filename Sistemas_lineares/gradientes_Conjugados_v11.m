%%%%%%%%%%%%%%%%%%%%% ALGORITMO GRADIENTES CONJUGADOS %%%%%%%%%%%%%%%%%%%%%

clear;
clc;
format short

disp('Metodo dos Gradientes Conjugados')
% epsilon = 10^1;
% A = [10 1 0
%      1 10 1
%      0 1 10];
% 
% B = [-11; -11; -1];

% epsilon = 1;
% A = [4 1;1 3];
% B = [-5;-4];

epsilon = 10^-2;
A = [ 16   4   4   0   0   0   0   0   0   0
      4   25  -3   6   0   0   0  10   0   0
      4   -3  30   8   0   2   0  -9   0   0
      0    6   8  47   8  -2   0   0   0   0
      0    0   0   8   17  3   2  -1   0   0
      0    0   2  -2   3  15   1  -3   3   0
      0    0   0   0   2   1  21  -4  -7   0
      0   10  -9   0  -1  -3  -4  52  -1   4
      0    0   0   0   0   3  -7  -1  14   0
      0    0   0   0   0   0   0   4   0  24];

B = [ 14.00
             -24.50 
              87.70 
             142.50 
               7.90 
              47.35 
             -46.45 
               8.45 
              -3.50 
              80.00 ];

linhas = length(A(:,1));

% Verificação Menores Positivas
comando = 1;
while comando == 1    
    comando = 0;
    for i = 1: linhas
    
       dets{i} = det(A(i,i));
    
       if dets{i} <= 0 
           disp("SISTEMA IMPOSSIVEL DE RESOLVER POR GRADIENTES CONJUGADOS")
           A = input();
           B = input();
           comando = 1;        
       end
    end

end
       disp("            ")
       disp("        TODAS AS MENORES SÃO POSTIVAS      ")

% Start Variáveis
t = zeros(linhas);

v{1} = t(:,1);
r{1} = A*v{1}+B;
p{2} = -r{1};  % Direção

i = 1;
while true

    
    t_min(i+1) = t_minimo(r, i, A, p);
    
    v{i+1} = v{i} + t_min(i+1)*p{i+1};
    r{i+1} = r{i} + t_min(i+1)*(A*p{i+1});
    
     %Critério de Parada
 
     vv = v{i+1}-v{i};
     norma = max(vv)/max(v{i+1});
  
     if norma > epsilon
         break
     end
    
    alfa(i+1) = calcular_alfa(r,i,A);
    
    p{i+2} = -r{i+1} + (alfa(i+1)*p{i+1}); 
    
    i = i+1;
end

disp( "  ")
disp( "          SOLUCÃO DO SISTEMA         ")
disp( "  ")
disp(     v{end})

function t = t_minimo(r,i, A, p)

    produto_residuo = 0;
    produto_Aresiduo = 0;
    f = length(A(:,1));
    
    if i == 1
        Ar = (A*r{i});
        for l = 1:f
        produto_residuo = produto_residuo + (r{i}(l) *r{i}(l));
        produto_Aresiduo = produto_Aresiduo + (Ar(l)*r{i}(l));
        end
    end
    if i>1
        Ap = (A*p{i+1});
        for l = 1:f
        produto_residuo = produto_residuo + (r{i}(l) *r{i}(l));
        produto_Aresiduo = produto_Aresiduo + (Ap(l)*p{i+1}(l));
        end
    end
    
    t = abs(produto_residuo)/abs(produto_Aresiduo);

end

function alfa = calcular_alfa(r,posicao,A)
    
    produto_residuofrente = 0;
    produto_residuo = 0;
    f = length(A(:,1));

    for l = 1:f

    produto_residuofrente = produto_residuofrente + (r{posicao+1}(l) *r {posicao+1}(l));
    produto_residuo = produto_residuo + (r{posicao}(l)*r{posicao}(l));
    
    end 
    alfa =  produto_residuofrente/produto_residuo;
end