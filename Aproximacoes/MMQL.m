%% MMQL

clc, clear
% Conjunto de Dados de Entrada
% X = [1 2 3 4 5 6 7 8 9 10];
% Y = [1.3 3.5 4.2 5.0 7.0 8.8 10.1 12.5 13.0 15.6];

% X = [1 2 3 4 5 6 7 8];
% Y = [0.5 0.6 0.9 0.8 1.2 1.5 1.7 2.0];

X = [-2 -1 0 1 2 3 4 5 6 7];
Y = log([10 8 4 3.5 2.1 1 0.5 0.3 0.2 0.1]);


%Start Variaveis
sxy = 0;
sx2 = 0;
sx = 0;
sy = 0;

% Gerando dados
m = length(X);

%Somatorio Variaveis
for i = 1:m
    sxy = sxy + X(i)*Y(i);
    sx2 = sx2 + X(i)^2;
    sx = sx + X(i);
    sy = sy +Y(i);
end

%Definindo a0 e a1
a0 = (sx2*sy - sxy*sx)/(m*sx2-sx^2);
a1 = (m*sxy-sx*sy)/(m*sx2-sx^2);

%Gerando RETA
for i = 1:m
    f(i) = a1*X(i)+a0;
end

figure(1), clf
subplot(121)
plot(X,f, '-')
hold on
legend('MMQL')
plot(X,Y,'O')
hold on
xlabel('x')
ylabel('F(x)')
axis square


    


