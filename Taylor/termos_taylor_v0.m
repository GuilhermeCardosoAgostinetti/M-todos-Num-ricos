
clc, clear
syms x a c
format short

f(x) = cos(x);%% Function Avaliable
n = 2;
P = 0;
a = 0;
x_x = 0.01
d = f(x);
for i = 1:n+1 %% Gerando as Derivadas Necessarias
  
  d = diff(d);
  derivada(i) = d;
  
end

disp("Derivadas:")
disp(derivada)

derivada(n+1) = subs(derivada(n+1),x,c);
R = derivada(n+1)/factorial(n+1)*(x-a)^(n+1);
pretty(R)


