%------------------------------------
%           Integração Numérica - Método dos Trapézios / Método de Simpson/
%           Método de Simpson Adaptativo
%------------------------------------------------------------------
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------
%
%       Chamada do Procedimento
%------------------------------
%       I = imt(f,n,a,b); Método dos Trapézios
%       I = ims(f,n,a,b); Método de Simpson
%       I = imsa(f,n,a,b,epsilon); Método de Simpson Adaptativo
%
%       Variaveis de Entrada Método dos Traézios e Método de Simpson
%       f - Função Avaliada
%       n - número de trapézios
%       a - Intevalo de integração Inicial
%       b - Intevalo de integração Final   
%
%       Variaveis de Método de Simpson Adaptativo
%       f - Função Avaliada
%       epslon - Erro Máximo
%       a - Intevalo de integração Inicial
%       b - Intevalo de integração Final
%       TOL - Loops Máximos
%------------------------------
%       Variaveis de Saida
%       I - Integral Numérica
% 
%------------------------------

clc, clear

%       ----------------
%       Entrada
%-----------------------

f= @(x) 1/(x+1);
n = 5;
a = 0;
b = 2;
epsilon = 10^-5;
TOL = 10000;
I = imsa(f,a,b,epsilon,TOL);

    
%       ----------------
%       Método dos Trapézios
%-----------------------

function I = imt(f,n,a,b)
    
    %       ----------------
    %       Gera o passo.
    %-----------------------
    h = (b-a)/n;
    soma_fx = 0;
    
    %       ------------------
    %       Somatória de f(xj)
    %-------------------------
    for j = 1:n-1
        soma_fx = soma_fx+f(a+j*h);
    end

    %       ------------------
    %       Cálculo Integral
    %-------------------------
    I = h/2*(f(a)+2*soma_fx+f(b));
    disp(I);
end

%       ----------------
%       Método de Simpson
%-----------------------

function I = ims(f,n,a,b)
   
    %       ----------------------
    %       Verifica e Pede n Par
    %-----------------------------  
    while mod(n,2)~= 0
        n = input("N:");
    end
    
    %       ----------------
    %       Gera o passo.
    %-----------------------    
    h = (b-a)/n;
    soma_fx1 = 0; 
    soma_fx2 = 0; 
    
    %       ------------------
    %       Somatória de f(x2j)
    %-------------------------
    for j = 1:(n/2)-1
        soma_fx1 = soma_fx1+f(a+(2*j)*h);
    end

    %       ------------------
    %       Somatória de f(x2j-1)
    %-------------------------    
    for j = 1:(n/2)
        soma_fx2 = soma_fx2+f(a+(2*j-1)*h);
    end

    %       ------------------
    %       Cálculo Integral
    %-------------------------
    I = h/3*(f(a)+2*soma_fx1+4*soma_fx2+f(b));
    disp(I)
end

%       ----------------------------
%       Método de Simpson Adaptativo
%-----------------------------------

function S = imsa(f,a,b,epsilon, TOL)
    
    i = 0;
    S = 0;
    intervalo = [a,b,epsilon];
    
    while i < TOL & length(intervalo)>0
        i = i+1;
        a = intervalo(1);
        b = intervalo(2);
        epsilon = intervalo(3);
        
        c = (a+b)/2;
        S1 = simpson(f,a,b);
        S2 = simpson(f,a,c) + simpson(f,c,b); 
        
        erro = abs(S1-S2);
    
        if erro < 15*epsilon
            S = S + S2;
            v = length(intervalo)/3;
            if v>1
                for k = 1:v-1
                   intervalo(3*k-2) = intervalo(3*(k+1)-2);
                   intervalo(3*k-1) = intervalo(3*(k+1)-1);
                   intervalo(3*k) = intervalo(3*(k+1));
                end
                for k = 1:3
                    intervalo(end) = [];
                end
            
            else
                intervalo(3) = [];
                intervalo(2) = [];
                intervalo(1)= []; 
            end
    
        else
           v = length(intervalo)/3;
           if v >1 
                for k = 1:v-1
                   intervalo(3*k-2) = intervalo(3*(k+1)-2);
                   intervalo(3*k-1) = intervalo(3*(k+1)-1);
                   intervalo(3*k) = intervalo(3*(k+1));
               end
               for k = 1:3
                   intervalo(end) = [];
               end
           else
                intervalo(3) = [];
                intervalo(2) = [];
                intervalo(1)= []; 
           end
           intervalo = [intervalo, a,c,epsilon/2,c,b,epsilon/2];
        end
        disp(length(intervalo))
    end
    
    function I = simpson(f,a,b)
            I = ((b-a)/6)*(f(a)+4*f((a+b)/2)+f(b));       
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