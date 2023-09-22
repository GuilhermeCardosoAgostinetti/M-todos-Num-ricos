%% Método de Newton 


clc, clear
format short

nvar = input("Variáveis:"); % Quantidade de Variáveis

for i=1:nvar % Cria Variáveis Simbólicas a1, a2, a3.... an
    eval(['syms a',num2str(i)])
end

MAX = 10; % Número Maximo de iterações
% epson_1 = 10^-2;
% epson_2 = 10^-2;
 % f = [a1+a2-3 a1^2+a2^2-9];
 % xi = [1 5];

% f = [ 3*a1-cos(a2*a3)-1/2 a1^2-81*(a2+0.1)^2+sin(a3)+1.06 exp(-a1*a2)+20*a3+(10*pi*-3)/3];
% xi = [0.1 0.1 -0.1];

%Gerando Equacoes

X = [-2 -1 0 1 2 3 4 5 6 7];
Y = [10 8 4 3.5 2.1 1 0.5 0.3 0.2 0.1];
m=10;
equacao1 = 0;
equacao2 = 0;

for i = 1:m
equacao1 = equacao1 + [Y(i)-a1*exp(a2*X(i))]*exp(a2*X(i));
equacao2 = equacao2 + [Y(i)-a1*exp(a2*X(i))]*a1*X(i)*exp(a2*X(i));
end

f = [equacao1 equacao2];
xi = [4.52 -0.52];

for k = 1:MAX
        % Substituindo Valores xi nas equações (Criando a Matriz B)
        f_sub = f;
    for i = 1:nvar
        for j = 1:nvar
        f_sub(i) = subs(f_sub(i),['a',num2str(j)],[xi(j)]);
        end
    end
    
        % Criando Matriz Jacobiana
        f_div_sub = f;
    for i = 1:nvar
        for j = 1:nvar % Calcula a Derivada
        d = diff(f_div_sub(i),['a',num2str(j)]);
            for l = 1:nvar % Substitui as incógnitas pelos valores de xi
                d = subs(d,['a',num2str(l)],[xi(l)]);
            end
        A_j(i,j) = d;
        end
    end
     A_j = double(A_j);
     B_j = double(-transpose(f_sub));
     X_resultado = A_j^(-1)*B_j;
     xf = xi + transpose(X_resultado);
     xi = xf;
     resultado = double(xf);
     xi = resultado;
end


% k=0;
% Y_grafico = zeros(length(X(1):0.005:X(end)));
% for i = X(1):0.005:X(end)
%     k = k+1; 
%     X_grafico(k) = i;
%     Y_grafico(k) = 4.603150412776761*exp(-0.411197592933566*X_grafico(k));
% end

% figure(2), clf
% plot(X_grafico, Y_grafico, '-')
% hold on
% xlabel('x')
% ylabel('P(x)')
% axis square
