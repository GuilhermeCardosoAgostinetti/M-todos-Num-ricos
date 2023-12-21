## Método Simplex
import numpy as np 


## VARIÁVEIS DE ENTRADA.
c = np.array([[-1, -1, 0, 0, 0]])
A = np.array([[1, 1,1, 0, 0],[1, -1,0, 1, 0],[-1, 1,0, 0, 1]])
b = np.array([[6],[4],[4]])
L=np.array([[1],[1],[0],[0],[0]])

#       ---------------------------
#      Gera Matriz Base e Normal
# ----------------------------------

n = len(A)
m = len(A.T)

Xb = np.array((A[:, (m-n):m]))
Xbv = np.arange(m-n,m)

Xn = np.array((A[:, 0:m-n]))
Xnv = np.arange(0,m-n)

Xb_inversa = Xb 
for k in range(4):
    #       -----------------------------------
    #       PASSO 1: Solução Básica Factível.
    #---------------------------------------
    print(".......................................................")
    print(" ITERCACAO ", k)
    x_f = np.dot(Xb_inversa,b)
    print("SOL. FACTÍVEL:")
    print(x_f)
    #       -----------------------------------
    #       PASSO 2: Calcular custos Relativos.
    #------------------------------------------

    #2.1 Matriz com os Custos relacionados a matriz base

    c_b = c[:, Xbv]

    vetor_lambda = np.dot(Xb_inversa.T,c_b.T)


    # 2.2 Cálculo dos custos reduzidos

    # Inicializando a lista c_red
    c_red = []

    # Iterando sobre as colunas não básicas
    for i in range(m - n):
        # Acessando os elementos de c usando Xnv[i]
        coluna_Xn = Xn[:, i].flatten()
        
        # Calculando c_red e adicionando à lista
        c_red.append(c[0, Xnv[i]] - np.dot(vetor_lambda.T, coluna_Xn))

    # Convertendo a lista para um array
    c_red = np.array(c_red)

    # Exibindo o resultado
    print("Vetor c_red:")
    print(c_red)

    t = min(c_red)
    indice_entra = np.where(c_red == t)[0][0]

    print(f"Variável que entra na base: {Xnv[indice_entra]}")

    #       -----------------------------------
    #       PASSO 3: Teste de Otimalidade.
    #------------------------------------------

    if t>=0:
        print("Solução Ótima.")
        print(x_f)
        break

    #       -----------------------------------
    #       PASSO 4: Cálculo da Direção simplex.
    #------------------------------------------

    d = np.dot(Xb_inversa, -Xn[:,indice_entra])
    print(d)

    ep = np.zeros(len(d))

    for i in range(len(d)):
        if d[i] < 0:
            ep[i] = (-x_f[i]) / d[i]

    ep = np.array(ep)
    indices_nao_nulos = np.nonzero(ep)
    ep = ep[indices_nao_nulos]

    print("Vetor ep:")
    print(ep)

    r = min(ep)
    indice_sai = np.where(ep == r)[0][0]
    print(indice_sai)

    #       -----------------------------------
    #       PASSO 6: ATUALIZAÇÃO DA PARTIÇÃO
    #------------------------------------------
    print(Xbv)
    print(Xnv)

    aux = Xbv.copy()

    # Atualizando Xbv
    aux[indice_sai] = Xnv[indice_entra]
    Xnv[indice_entra] = Xbv[indice_sai]
    Xbv = aux

    print("Xbv atualizado:")
    print(Xbv)
    print(Xnv)

    # Reiniciando as matrizes base e normal
    Xb = np.zeros((n, 0))
    Xn = np.zeros((n, 0))

    # Atualizando Xb
    for i in Xbv:
        Xb = np.column_stack((Xb, A[:, i]))

    # Atualizando Xn
    for i in Xnv:
        Xn = np.column_stack((Xn, A[:, i]))

    # Inicializando Xb_inversa

    # Inicializando Xb_inversa
    Xb_in = np.zeros((n, n))

    # Atualizando Xb_inversa
    for i in range(n):
        if indice_sai != i:
            Xb_in[i, :] = Xb_inversa[i, :] - d[i] / d[indice_sai] * Xb_inversa[indice_sai, :]
        else:
            Xb_in[i, :] = -1 / d[indice_sai] * Xb_inversa[indice_sai, :]


    Xb_inversa = Xb_in
    print("Matriz Xb_inversa atualizada:")
    print(Xb_inversa)

    print("Matriz Xb:")
    print(Xb)

    print("Matriz Xn:")
    print(Xn)
