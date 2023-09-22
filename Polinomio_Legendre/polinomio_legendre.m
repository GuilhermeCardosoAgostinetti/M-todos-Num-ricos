%------------------------------------
%           Polinômio de lagrange - Cálculo das Raízes
%------------------------------------------------------------------
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------
%
%       Chamada do Procedimento
%------------------------------
%       I = imt(f,n,a,b); Método dos Trapézios
%       
%
%       Variaveis de Entrada
%       n -
%       
%                
%------------------------------
%       Variaveis de Saida
%       p - polinomio no n termo
%       zeros - zero do polinômio de legendre
%-----------------------------

function [p,zeros] = pleg(n);
syms t
n = n+1;
p{1} = 1;
p{2} = t;

for i = 2:n-1
    p{i+1} = ((2*(i-1)+1)/((i-1)+1))*t*p{i}-((i-1)/((i-1)+1))*p{i-1};
end


zeros = solve(p{n}==0);
p = p{n};

end
