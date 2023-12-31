
## ARVORE
class No:

    def __init__(self, valor):
        self.valor = valor
        self.esquerda = None
        self.direita = None
   
    def obtervalor(self):
        return self.valor
   
    def setesquerda(self, esquerda):
        self.esquerda = esquerda

    def setdireita(self, direita):
        self.direita = direita

    def obteresquerda(self):
        return self.esquerda

    def obterdireita(self):
        return self.direita

