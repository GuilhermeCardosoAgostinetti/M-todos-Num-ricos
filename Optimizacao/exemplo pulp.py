import pulp 
import xlrd
import numpy as np

#@title = Modelo Problema da Mistura
#@autor = Guilherme Cardoso Agostinetti

#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMaximize)
x = pulp.LpVariable.dicts(indexs=[1,2,3,4,5,6] , cat = pulp.LpContinuous, lowBound=0, name='x')

### ------------ Gera as Restrições

modelo.addConstraint(2*x[1]+6*x[2]+3*x[3]+2*x[4]+3*x[5]+4*x[6]<=600)   
      
modelo.setObjective(x[1]+2*x[2]+4*x[3]+5*x[5]+x[6])
modelo.solve()

x_sol = {i: x[i].value() for i in [1,2,3,4,5,6]}
print(f'x = {x_sol}')
