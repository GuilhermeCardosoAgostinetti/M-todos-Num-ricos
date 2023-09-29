import pulp 
import xlrd
import numpy as np

##restricoes = pd.read_csv('funcao_objetiva.csv')
##model = pulp.LpProblem('Exemplo_01', sense = pulp.LpMaximize)
##print(restricoes[0])
wb = xlrd.open_workbook('funcao_objetiva.xlsx')
p1 =wb.sheet_by_name('instancias01')

v = p1.rol_values(0)
print(v)
x = pulp.LpVariable.dicts(indexs=v, cat = pulp.LpContinuous, lowBound=0,name='x')

model.addConstraint(2*x[1] + 4*x[2] <= 10, name ='restricao_1')
model.addConstraint(6*x[1] + x[2] <= 20, name ='restricao_2')
model.addConstraint(x[1] - x[2]  <= 30, name ='restricao_3')

model.setObjective(3*x[1] + 5*x[2])


model.solve()

x_sol = {i: x[i].value() for i in [1,2]}
print(f'x = {x_sol}')
