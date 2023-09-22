% ALGORITMO GRADIENTES CONJUGADOS

clear, clc
A = [4, 3, 0;3,4,-1;0,-1,4];
b = [24;30;-24];
x_old = [0;0;0];
epslon = 10^-5;
ITMAX = 3;

r_old = b-A*x_old;
v = r_old;
x = x_old;

for k = 1:ITMAX
    if k>1
    r_old = r;
    end

Av = A*v;
t = dot(r_old,r_old)/dot(v,Av);
r = r_old - t*Av;
x = x+t*v;

normara = sqrt(r(1,1)^2+r(2,1)^2+r(3,1)^2);
normar = norm(r);
    if norm(r)<= epslon
      disp("CONVERGIU! A SOLUCÃO É:");
      disp(x);
      break
    else
      s = dot(r,r)/dot(r_old,r_old);
      v = r+s*v;
    end

end