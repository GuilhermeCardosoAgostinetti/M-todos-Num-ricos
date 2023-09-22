%------------------------------------
%           Spline Linear Cúbica
%------------------------------------
%
%
%       Chamada do Procedimento
%------------------------------
%       [P_x,P_y]= slc(X,Y)
%
%       Variaveis de Entrada
%      x - Vetor Cordenada Cartesiana x 
%      y - Vetor Cordenada Cartesiana y
%      n - Passo no polinômio gerado
%------------------------------
%       Variaveis de Saida
%      P_x - Polinômio x(t)
%      P_y - Polinômio t(t)
%      Gráfico.
%------------------------------

clc, clear

%       ----------------
%       Calculo h_k
%-----------------------

x = [5, 10, 15, 20, 25];
y = [5, 20, 16, 22, 18];
p = 0.1;
[P1, P2] = slc(x,y,p);

function [P_x,P_y]= slc(x,y,p)
    syms T
    n = length(x) - 1;
    for i = 1: length(x)
        t(i) = i;
    end
    
    %       ----------------
    %       Calculo h_k
    %-----------------------
    for i = 1:n
        h(i+1) = t(i+1) -t(i);
    end
    
    %       ----------------
    %       Gera Matriz A
    %-----------------------
    
    for i = 1:n-1
        for j = 1:n-1
            if i == j
                A(i,j) = 2*(h(i+1)+h(i+2));
            elseif i == j+1
                A(i,j) = h(i+2);
            elseif j == i+1
                A(i,j) = h(i+2);
            else
                A(i,j) = 0;
            end
        end
    end
    
    for i = 1:n-1
        Bx(1,i) = ((x(i+2)-x(i+1))/h(i+2))-((x(i+1)-x(i))/h(i+1));
        By(1,i) = ((y(i+2)-y(i+1))/h(i+2))-((y(i+1)-y(i))/h(i+1));
    end
    
    %       ----------------
    %       G_k
    %-----------------------
    
    G_x = 6*Bx*A^(-1);
    G_y = 6*By*A^(-1);
    
    %       ------------------------
    %       Condição Spline Natural
    %-------------------------------
    
    for i = 1:n-1
        G_x(n+1-i) = G_x(n-i) ;
        G_y(n+1-i) = G_y(n-i) ;
    end
    
    G_x(1) = 0;
    G_x(n+1) = 0;
    G_y(1) = 0;
    G_y(n+1) = 0;

    %       ------------------------
    %       Condição Spline Natural
    %-------------------------------   
    for k = 2:n+1
        a_x(k) = (G_x(k)-G_x(k-1))/6*h(k);
        a_y(k) = (G_y(k)-G_y(k-1))/6*h(k);
    
        b_x(k) = G_x(k)/2;
        b_y(k) = G_y(k)/2;
    
        c_x(k) = ((x(k) - x(k-1))/h(k))+(2*h(k)*G_x(k)+h(k)*G_x(k-1))/6;
        c_y(k) = ((y(k) - y(k-1))/h(k))+(2*h(k)*G_y(k)+h(k)*G_y(k-1))/6;
    
        d_x(k)=x(k);
        d_y(k)=y(k);
    end

    %       ------------------------
    %       Polinômios x(t), y(t) 
    %-------------------------------   

    for k = 2:n+1
        P_x(k) = a_x(k)*(T-t(k))^3+b_x(k)*(T-t(k))^2 + c_x(k)*(T-t(k))+d_x(k);
        P_y(k) = a_y(k)*(T-t(k))^3+b_y(k)*(T-t(k))^2 + c_y(k)*(T-t(k))+d_y(k);
    end
    
    %       ------------------------
    %       Pontos da Spline
    %-------------------------------
    v = 0;
    for i = 2:n+1
        for j = t(i-1):p:t(i)
            v = v+1;
            x_final(v) = subs(P_x(i),T,j);
            y_final(v) = subs(P_y(i),T,j);
        end
    end

    %       ------------------------
    %       Plots
    %-------------------------------   

    plot(x_final,y_final);

end

%-----------------------------------------------------------------------
%--------------------------------------------------
%       Guilherme Cardoso Agostinetti
%       Data da última Atualização - 21/08/2023    
%       Mestrando de Matemática Aplicada e Computacional - PGMAC - UEL
%       CCE - UEL
%       e-mail: guilherme.agostinetti@uel.br
%--------------------------------------------------