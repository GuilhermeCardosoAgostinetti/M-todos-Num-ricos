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


arq = xlrd.open_workbook('C:\\Users\\Guilherme\\Documents\\GitHub\\Metodos_Numericos\\Optimizacao\\Modelo_prob_mistura\\instancias.xlsx')

plan = arq.sheet_by_name('instancia02')
quantidade = arq.sheet_by_name('intancia02_quantidades')

Q = quantidade.row_values(0) # Pega o valor da Linha 0 Posição 0
print("Quantidade Itens: ",Q)
for k in range(plan.nrows): #itere sobre os itens da aba 
    print(plan.row(k))
print(" ")
# vetor Custo C[j]
c = plan.row_values(-1) # Importa os VAlores da Ultima Linha da plan.
c = list(filter(bool, c)) # Retira todos os espaços vazios.
c = list(filter(lambda x: not isinstance(x, str), c)) # Filtra todos os Caracteres
print(" ")
print(f"Coeficientes: {c}")

# Cálculo n/m
n = len(c) # Número de ingredientes na mistura
m = len(plan.col_values(0))-2 #Número de Componentes
print(" ")
print(f"Número de ingredientes na mistura {n}")
print(f"Número de Componentes {m}")

# Matriz a[i][j]
a=[0]*m
for i in range(m):
    a[i] = plan.row_values(i+1)
    a[i] = list(filter(lambda x: not isinstance(x, str), a[i])) #Filtra Str
    for k in range(len(a[i])-len(c)):
        a[i]=a[i][:-1]
print(f"Matriz a: {a}")
print(" ")

# Vetor b[i]_min
t = len(plan.row_values(0))-n-1
print(f"Quantidade de Produtos(t): {t}")
print(" ")
b=[0]*t
for i in range(t):
    b[i] = plan.col_values(n+1+i)
    b[i] = b[i][1:]
    b[i] = b[i][:-1]

print(f"Matriz b: {b}")
print(" ")

v = len(b)/2 # Quantidade de Produtos Fabricados
v = int(v)
print(v)
#----------------------Gerando Modelo---------------------------------------------------
# Criando Problema
modelo = pulp.LpProblem('Exemplo_01', sense = pulp.LpMinimize) #Cria o Modelo para Resolução
nn = list(range(1,int((v*n)+1))) #Vetor Index
x = pulp.LpVariable.dicts(indexs=nn , cat = pulp.LpContinuous, lowBound=0, name='x') #Cria as Variáveis

### ------------ Gera as Restrições
vetor_indicex = [[0]*n for _ in range(v)] # Vetor para chamar o X.
variavel = 0
for t in range(v):
    for j in range(n):
        variavel = variavel + 1
        vetor_indicex[t][j] = variavel

ib = 0
for t in range(v):
    ## Restrições b_min
    
    for i in range(m):
        if b[ib][i] != "":
            eq=0
            for j in range(n):
                eq = eq + a[i][j]*x[vetor_indicex[t][j]]
            eq = eq>=b[ib][i]*Q[t] 
            print(f"Restrição {eq}")
            modelo.addConstraint(eq)    # Insere a restrição
    ib += 1
    ## Restrições b_max

    for i in range(m):
        if b[ib][i] != "":
            eq=0
            for j in range(n):
                eq = eq + a[i][j]*x[vetor_indicex[t][j]]
            eq = eq<=b[ib][i]*Q[t]
            print(f"Restrição {eq}")
            modelo.addConstraint(eq)   # Insere a restrição 
    ib += 1
for t in range(v): # Limite da Quantidade Máxima.
    quantidade = 0
    for j in range(n):
        quantidade = quantidade +x[vetor_indicex[t][j]]
    quantidade = quantidade == 1*Q[t] 
    print(f"Restrição {quantidade}")
    modelo.addConstraint(quantidade) # Insere a restrição



#Gera a Função Objetiva
fo = 0
for t in range(v):
    for j in range(n):
        fo = fo + c[j]*x[vetor_indicex[t][j]]
    print(fo)

modelo.setObjective(fo)# Insera a função objetiva no Problema
modelo.solve() # Chama a resolução do Problema

x_sol = {i: x[i].value() for i in nn} # Print Respota
print(f'x = {x_sol}')
