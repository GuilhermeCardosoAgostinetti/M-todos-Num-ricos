%%% Interpolação Spline Liner Sem monotonicidade  
clear, clc 
syms ;. 

a = [1,10, 5,2,7,5,5];
b = [1, 1,10,2,2,7,5];
t = 1:1:length(a);
guardar_x =[];
guardar_y = [];
% n=1000
% h = (a(end)-a(1))/n

for i = 1:(length(a)-1)
  
S_a = a(i)*((t(i+1)-p)/(t(i+1)-t(i)))+a(i+1)*((p-t(i))/(t(i+1)-t(i)));
S_b = b(i)*((t(i+1)-p)/(t(i+1)-t(i)))+b(i+1)*((p-t(i))/(t(i+1)-t(i)));
Spline_a(i) = S_a;
Spline_b(i) = S_b;

end

for i = 1:length(t)-1
     x = subs(Spline_a(i),p,i);
     y = subs(Spline_b(i),p,i);
     guardar_x = [guardar_x,x];
     guardar_y = [guardar_y,y]; 
end

guardar_x = double(guardar_x)
guardar_y = double(guardar_y)
plot(guardar_x,guardar_y)

