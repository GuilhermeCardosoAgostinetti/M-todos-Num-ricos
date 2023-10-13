import numpy as np

c = np.array([-1, -2, 0, 0])
A = np.array([[1,1,1,0],[0,1,0,1]])
b = np.array([[6],[3]])

postoA = np.linalg.matrix_rank(A)
postoAb = np.linalg.matrix_rank(np.concatenate((A, b), axis=1))
#postoAb = np.linalg.matrix_rank()
print(postoA)
print(postoAb)

if postoA == postoAb:
    gdl = len(A[1,:])-postoA
    print(gdl)
else:
    print("ERRO")

    

