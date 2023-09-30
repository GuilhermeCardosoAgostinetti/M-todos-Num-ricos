import pulp 
import xlrd
import numpy as np

#@title = Modelo Problema da Mistura
#@autor = Guilherme Cardoso Agostinetti

# Variáveis
# n: Número de ingredientes na mistura
# m: Número de Componentes
# i = 1...m
# j = 1...n
# a[i][j]: Fração do componente i no ingrediente j
# b[i]: Fração do componente i na mistura
# c[j]: Custo de uma unidade do ingrediente i
# Q: Quantidade de Mistura à ser produzida

arq = xlrd.open_workbook('C:\\Users\\Guilherme Cardoso A\\Documents\\GitHub\\Metodos_Numericos\\Optimizacao\\Modelo_prob_mistura\\instancias01.xlsx')
plan = arq.sheet_by_name('instancia01')

# C - custo de uma unidade do ingredite i
for k in range(plan.nrows): #itere sobre os itens da aba 
    print(plan.row(k))

# vetor Custo 
c = plan.row_values(-1)
c = list(filter(bool, c))
c = list(filter(lambda x: not isinstance(x, str), c))


m = len(plan.col_values(0))-2
# Vetor a[i][j]
a=[0]*m
for i in range(m):
    a[i] = plan.row_values(i+1)
    a[i] = list(filter(lambda x: not isinstance(x, str), a[i]))
y = len(a[0])-len(c)
print(y)
print(a)
n = len(c)



'''
#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMinimize)
nn = list(range(1,n+1)) #Vetor Index
x = pulp.LpVariable.dicts(indexs=nn , cat = pulp.LpContinuous, lowBound=0, name='x')

#Gera as Restrições
modelo.addConstraint(0.2*x[1] + 0.5*x[2] + 0.4*x[3] >= 0.3)
modelo.addConstraint(0.6*x[1] + 0.4*x[2] + 0.4*x[3] >= 0.5)
modelo.addConstraint(x[1] + x[2] + x[3] == 1)

#Gera a Função Objetiva
fo = 0
for i in range(n):
    fo = fo + c[i]*x[i+1]
    print(i)
print(fo)

modelo.setObjective(fo)
modelo.solve()

x_sol = {i: x[i].value() for i in nn}
print(f'x = {x_sol}')
'''