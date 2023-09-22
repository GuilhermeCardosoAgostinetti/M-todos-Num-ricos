%%% Interpolação Spline Liner Sem monotonicidade --------------------------  
%---------- Autor: Guilherme Cardoso Agostinetti --------------------------
%--------------------------------------------------------------------------

clear, clc
syms p


%a = xlsread('dados_interpolação_spline.xlsx',1,'B3:B9')
%b = xlsread('dados_interpolação_spline.xlsx',1,'C3:C9')

a = [2, 3,3.2,6,12,14.8,15,16,2];
b = [14, 10,10,1,1,10,10,14, 14];

% Entrada de Dados (Cordanadas de X, Y)
% n = input("QUATIDADE DE ELEMENTOS");
% a = [];
% b = [];
 guardar_x =[];
 guardar_y = [];
% 
% for i = 1:n
%     a = [a, input('DIGITE X:')];
% end
% 
% for i =1:n
%     b = [b,input('DIGITE Y:')];
% end


% -------------------------------------------------------------------------
% -------GERAR A SPLINE S_a = x(t) e S_b = y(t)----------------------------
% -------------------------------------------------------------------------

t = 1:1:length(a);

for i = 1:(length(a)-1)  
    S_a = a(i)*((t(i+1)-p)/(t(i+1)-t(i)))+a(i+1)*((p-t(i))/(t(i+1)-t(i)));
    S_b = b(i)*((t(i+1)-p)/(t(i+1)-t(i)))+b(i+1)*((p-t(i))/(t(i+1)-t(i)));
    Spline_a(i) = S_a;
    Spline_b(i) = S_b;
end

% -------------------------------------------------------------------------
% -------x(t) e y(t) por t = 1:end ----------------------------------------
% -------------------------------------------------------------------------

for i = 1:length(t) 
     if i == length(t)
         x = subs(Spline_a(i-1),p,i);
         y = subs(Spline_b(i-1),p,i);
         guardar_x = [guardar_x,x];
         guardar_y = [guardar_y,y];   
     else
         x = subs(Spline_a(i),p,i);
         y = subs(Spline_b(i),p,i);
         guardar_x = [guardar_x,x];
         guardar_y = [guardar_y,y]; 
     end
end

% Plot 
guardar_x = double(guardar_x);
guardar_y = double(guardar_y);
plot(guardar_x,guardar_y);

%-----------------------------------------------------------------------
%--------------------------------------------------
%       Guilherme Cardoso Agostinetti
%       Data da última Atualização - 20/08/2023    
%       Mestrando de Matemática Aplicada e Computacional - PGMAC - UEL
%       CCE - UEL
%       e-mail: guilherme.agostinetti@uel.br
%--------------------------------------------------
