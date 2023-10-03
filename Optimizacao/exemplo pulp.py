import pulp 
import xlrd
import numpy as np

#@title = Modelo Problema da Mistura
#@autor = Guilherme Cardoso Agostinetti

#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMaximize)
x = pulp.LpVariable.dicts(indexs=[1,2] , cat = pulp.LpContinuous, lowBound=0, name='x')

### ------------ Gera as Restrições

modelo.addConstraint(2*x[1]+x[2]<=5000)   
modelo.addConstraint(4*x[1]+5*x[2]<=15000)   
modelo.setObjective(10*x[1]+7*x[2])
modelo.solve()

x_sol = {i: x[i].value() for i in [1,2]}
print(f'x = {x_sol}')
