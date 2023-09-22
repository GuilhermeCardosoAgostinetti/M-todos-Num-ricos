%------------------------------------
%           Itegral Numérica - Quadratura Gaussiana
%------------------------------------------------------------------
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------
%
%       Chamada do Procedimento
%       
%       [p,zeros,w,I] = pleg(n,f,a,b);
%
%------------------------------
%       Variáveis de Entrada
%       f - Função Avaliada
%       n - número de trapézios
%       a - Intevalo de integração Inicial
%       b - Intevalo de integração Final   
%------------------------------
%       Variaveis de Saida
%       p - polinomio no n termo
%       zeros - zero do polinômio de legendre
%       w - wi
%       I - Valor da Integral
%------------------------------
clear, clc 

format short g
f = @(x) exp(x^2);

[p,zeros,w,I] = pleg(15,f,0,4);

function [p,zeros,w,I] = pleg(n,f,a,b)
    syms t
    I = 0;
    n = n+1;
    p{1} = 1;
    p{2} = t;
    
    if a ~= -1 || b ~= 1
        syms x
        c = f(x);
        j = 1/2*(a+b+x*(b-a));
        k = (b-a)/2;
        c = subs(c,x,j);
        c = c*k;
        c = simplify(c);
    end
    f = matlabFunction(c);

    for i = 2:n-1
        p{i+1} = ((2*(i-1)+1)/((i-1)+1))*t*p{i}-((i-1)/((i-1)+1))*p{i-1};
    end
    zeros = double(transpose(solve(p{n}==0))) ;
    p = p{n};
    
    for i = 1:n-1
        w(i) = (1/(subs(diff(p,t),zeros(i)))^2)*(2/(1-zeros(i)^2));
    end

    for i = 1: n-1
        I = I + w(i)*f(zeros(i));
    end
    I = double(I);
    disp(I);
end

%-----------------------------------------------------------------------
%--------------------------------------------------
%       Guilherme Cardoso Agostinetti
%       Data da última Atualização - 26/08/2023    
%       Mestrando de Matemática Aplicada e Computacional - PGMAC - UEL
%       CCE - UEL
%       e-mail: guilherme.agostinetti@uel.br
%--------------------------------------------------