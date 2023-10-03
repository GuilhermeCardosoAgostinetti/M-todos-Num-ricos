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
# b[i]_min: Fração do componente i na mistura
# c[j]: Custo de uma unidade do ingrediente i
# Q: Quantidade de Mistura à ser produzida

arq = xlrd.open_workbook('C:\\Users\\Guilherme Cardoso A\\Documents\\GitHub\\Metodos_Numericos\\Optimizacao\\Modelo_prob_mistura\\instancias01.xlsx')
plan = arq.sheet_by_name('instancia01')
quantidade = arq.sheet_by_name('intancia01_quantidades')

Q = quantidade.row_values(0)[0]
print(Q)
for k in range(plan.nrows): #itere sobre os itens da aba 
    print(plan.row(k))

# vetor Custo C[j]
c = plan.row_values(-1)
c = list(filter(bool, c))
c = list(filter(lambda x: not isinstance(x, str), c))
print(c)
# Cálculo n/m
n = len(c)
m = len(plan.col_values(0))-2
print(n)
print(m)
# Matriz a[i][j]
a=[0]*m
for i in range(m):
    a[i] = plan.row_values(i+1)
    a[i] = list(filter(lambda x: not isinstance(x, str), a[i]))
    for k in range(len(a[i])-len(c)):
        a[i]=a[i][:-1]
print(a)
# Vetor b[i]_min

t = len(plan.row_values(0))-n-1
print(t)
b=[0]*t
for i in range(t):
    b[i] = plan.col_values(n+1+i)
    b[i] = b[i][1:]
    b[i] = b[i][:-1]
print(b)

v = len(b)/2
v = int(v)
#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMinimize)
nn = list(range(1,int((v*n)+1))) #Vetor Index
x = pulp.LpVariable.dicts(indexs=nn , cat = pulp.LpContinuous, lowBound=0, name='x')

### ------------ Gera as Restrições
vetor_indicex = [[0]*n for _ in range(v)]
variavel = 0

for t in range(v):
    for j in range(n):
        variavel = variavel + 1
        vetor_indicex[t][j] = variavel

for t in range(v):
    ## Restrições b_min
    if b[0][0] != "":
        for i in range(m):
            eq=0
            for j in range(n):
                eq = eq + a[i][j]*x[vetor_indicex[t][j]]
            eq = eq>=b[0][i]*Q 
            print(f"Restrição {eq}")
            modelo.addConstraint(eq)    

    ## Restrições b_max
    if b[1][0] != "":
        for i in range(m):
            eq=0
            for j in range(n):
                eq = eq + a[i][j]*x[vetor_indicex[t][j]]
            eq = eq<=b[1][i]*Q 
            print(f"Restrição {eq}")
            modelo.addConstraint(eq)    

for t in range(v):
    quantidade = 0
    for j in range(n):
        quantidade = quantidade +x[vetor_indicex[t][j]]
    quantidade = quantidade == 1*Q   
    print(f"Restrição {quantidade}")
    modelo.addConstraint(quantidade)



#Gera a Função Objetiva
fo = 0
for j in range(n):
    fo = fo + c[j]*x[j+1]
print(fo)

modelo.setObjective(fo)
modelo.solve()

x_sol = {i: x[i].value() for i in nn}
print(f'x = {x_sol}')
