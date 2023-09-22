%% Interpolação Spline Liner com monotonicidade 

clear, clc
syms x

a = [5 , 10, 17, 21, 25];
b = [0 , 5, 9, 7, 0];
guardar_x =[]
guardar_y = []
n=1000
h = (a(end)-a(1))/n

for i = 1:(length(a)-1)
  
S = b(i)*((a(i+1)-x)/(a(i+1)-a(i)))+b(i+1)*((x-a(i))/(a(i+1)-a(i)))
vector(i) = S

end

for i = 1:length(a)-1

  f = matlabFunction(vector(i))
  x = a(i):h:a(i+1)
  y = f(x)
  guardar_x = [guardar_x,x]
  guardar_y = [guardar_y,y] 
end

plot(guardar_x,guardar_y)

