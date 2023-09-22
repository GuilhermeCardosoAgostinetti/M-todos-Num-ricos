


clc, clear
format short

syms x

f(x) = sqrt(x); %## Função
n = 3;
P = 1;
a = 2;
x_x = 0.01
d = f(x);

for i = 1:n+1 %## Gerando as Derivadas Necessarias
  d = diff(d);
  derivada(i) = d; 
end

disp(derivada)

for i = 1: n
  z = subs(derivada(i),x,a);
  P = P + (z/factorial(i))*(x-a)^i;
end

P(x) = f(a) + P;
disp(P)

P(x_x)