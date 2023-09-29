import pulp 
import xlrd
import numpy as np
import pandas as pd

fo = 0
##restricoes = pd.read_csv('//funcaoobjetiva.csv')
arq = xlrd.open_workbook('C:\\Users\\Guilherme Cardoso A\\Documents\\GitHub\\Metodos_Numericos\\dados.xlsx')
plan = arq.sheet_by_name('instancias01')

funcao_objetiva = plan.col_values(0)
print(len(funcao_objetiva))

n_funcao_objetiva = np.arange(1,len(funcao_objetiva)+1)

model = pulp.LpProblem('Exemplo_01', sense = pulp.LpMaximize)
model
x = pulp.LpVariable.dicts(indexs=n_funcao_objetiva, cat = pulp.LpContinuous, lowBound=0, name='x')
print(x[1])
teste = 2*x[1] + 4*x[2] <= 10
model.addConstraint(teste, name ='restricao_1')
model.addConstraint(6*x[1] + x[2] <= 20, name ='restricao_2')
model.addConstraint(x[1] - x[2]  <= 30, name ='restricao_3')


for i in range(1,3):
    fo = fo + funcao_objetiva[i-1]*x[i]

model.setObjective(fo)


model.solve()

x_sol = {i: x[i].value() for i in n_funcao_objetiva}
print(f'x = {x_sol}')
