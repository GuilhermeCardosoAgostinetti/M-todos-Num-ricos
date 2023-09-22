%% Algoritmo Cálculo de Taylor
% Desenvolvedor:Guilherme Cardoso Agostinetti

clc, clear
syms x c
format short

f(x) = sin(x); %% Função Avaliada
n = 10; %% Quantidade de Termos.
P = 0; %% Polinômio
a = 0; %% Polinômio
xx = 0.01 %% Valor de X
d = f(x);
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

P(x) = f(a) + P;

disp("P(x)=")
pretty(P)
pretty(P(xx))

derivada(n+1) = subs(derivada(n+1),x,c);
R = derivada(n+1)/factorial(n+1)*(x-a)^(n+1);
pretty(R)