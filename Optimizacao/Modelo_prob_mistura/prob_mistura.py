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

arq = xlrd.open_workbook('C:\\Users\\guilh\\OneDrive\\Documentos\\GitHub\\Metodos_Numericos\\Optimizacao\\Modelo_prob_mistura\\instacias.xlsx')
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

# Cálculo n/m
n = len(c)
m = len(plan.col_values(0))-2

# Matriz a[i][j]
a=[0]*m
for i in range(m):
    a[i] = plan.row_values(i+1)
    a[i] = list(filter(lambda x: not isinstance(x, str), a[i]))
    for k in range(len(a[i])-len(c)):
        a[i]=a[i][:-1]

# Vetor b[i]_min
b=[0]*m
for i in range(m):
    b[i] = plan.col_values(n+1+i)
    b[i] = b[i][1:]
    b[i] = b[i][:-1]
print(b)

t = len(b)/2

#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMinimize)
nn = list(range(1,int((t*n)+1))) #Vetor Index
x = pulp.LpVariable.dicts(indexs=nn , cat = pulp.LpContinuous, lowBound=0, name='x')

### ------------ Gera as Restrições


## Restrições b_min
if b[0][0] != "":
    for i in range(m):
        eq=0
        for j in range(n):
            eq = eq + a[i][j]*x[j+1]
        eq = eq>=b[0][i]*Q 
        print(f"Restrição {eq}")
        modelo.addConstraint(eq)    

## Restrições b
if b[1][0] != "":
    for i in range(m):
        eq=0
        for j in range(n):
            eq = eq + a[i][j]*x[j+1]
        eq = eq<=b[1][i]*Q 
        print(f"Restrição {eq}")
        modelo.addConstraint(eq)    

quantidade = 0
for j in range(n):
    quantidade = quantidade +x[j+1]
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
