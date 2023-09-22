%%  MMQP

clear, clc
% Conjunto de Dados de Entrada.
% X = [1 2 3 4 5 6 7 8];
% Y = [0.5 0.6 0.9 0.8 1.2 1.5 1.7 2.0];

X = [-2 -1 0 1 2 3 4 5 6 7];
Y = log([10 8 4 3.5 2.1 1 0.5 0.3 0.2 0.1]);

Y2 = [10 8 4 3.5 2.1 1 0.5 0.3 0.2 0.1];
% X = [0 0.25 0.50 0.75 1];
% Y = [1 1.2840 1.6487 2.1170 2.7183];

n = 5;
m = length(X);

if n>=m-1
   n = input("Grau Polinomial invalido");
end

% Calculando Potencias x.
for i = 0:2*n
    x_soma = 0;
    for j = 1:m
    x_soma = x_soma + X(j)^i;
    end
    x_potencia(i+1) = x_soma;
end


% Calculando B.
B = zeros(1,n+1);
for i = 1:n+1
    for j = 1:m
        B(1,i) = B(i) + (Y(j)*X(j)^(i-1));
    end
end


% Matriz ( Organizando as Potencias).
A = zeros(n+1);
for i = 1:n+1
    k = [i:i+n];
    for j = 1:n+1
     A(i,j) = x_potencia(k(j));
    end
end

%calculando os Coeficientes.
C = A^(-1)*transpose(B);
C = transpose(C);


%Gerando Polinomio.
k=0;
Y_grafico = zeros(length(X(1):0.005:X(end)));
for i = X(1):0.005:X(end)
    k = k+1; 
    X_grafico(k) = i;
    for j = 0:n
        Y_grafico(k) = Y_grafico(k) + C(j+1)*X_grafico(k)^j;
        Y_grafico2(k) = 4.529151*exp(-0.526058*X_grafico(k));
        Y_grafico3(k) = 4.603150412776761*exp(-0.411197592933566*X_grafico(k));
    end
end

figure(1), clf
plot(X_grafico, Y_grafico(:,1), '-')
hold on
title('MMQL - Linearizado')
plot(X,Y,'O')
hold on
xlabel('x')
ylabel('g(x)')
axis square

figure(2), clf
plot(X_grafico, Y_grafico3, '-')
hold on
title('Minimos Quadrados não Linear')
plot(X,Y2,'O')
hold on
xlabel('x')
ylabel('H(x)')
axis square



