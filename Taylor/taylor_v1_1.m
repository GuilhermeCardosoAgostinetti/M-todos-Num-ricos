%% Algoritmo Cálculo de Taylor
% Desenvolvedor:Guilherme Cardoso Agostinetti
clc, clear
syms x c
format short
  

[A,B,C] = taylor(input("Função Desenjada: "),input("Número de Termos:"),0,0, input("Para x=")); 
Resutlado = [A,B,C];
pretty(Resutlado)

function [L,Ps,Re] = taylor(f,n,P,a,xx)
    syms x c
    format short
    d = f;

    for i = 1:n+1 %% Gerando as Derivadas Necessarias
      d = diff(d);
      derivada(i) = d;
    end

    disp("Derivadas:")
    disp(derivada)
    
    for i = 1: n %% Criando cada termo dos Polinômios
      z = subs(derivada(i),x,a);
      P = P + (z/factorial(i))*(x-a)^i;
    end

    L=P;
    Ps = subs(P,x,xx);
    derivada(n+1) = subs(derivada(n+1),x,c);
    Re = derivada(n+1)/factorial(n+1)*(x-a)^(n+1);
end

