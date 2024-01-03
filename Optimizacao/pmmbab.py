class Item:
    def __init__(self, peso, valor):
        self.peso = peso
        self.valor = valor

def mochila_0_1(items, capacidade):
    # Função para calcular o limite (bound) de um nó
    def calcular_limite(no, capacidade_restante, valor_atual):
        limite = valor_atual
        i = no
        while i < len(items) and capacidade_restante >= items[i].peso:
            capacidade_restante -= items[i].peso
            limite += items[i].valor
            i += 1
        if i < len(items):
            limite += capacidade_restante * (items[i].valor / items[i].peso)
        return limite

    # Função principal do branch and bound
    def branch_and_bound(no, capacidade_restante, valor_atual):
        nonlocal melhor_valor
        if capacidade_restante < 0:
            return
        if no == len(items):
            if valor_atual > melhor_valor:
                melhor_valor = valor_atual
            return
        limite = calcular_limite(no, capacidade_restante, valor_atual)
        if limite <= melhor_valor:
            return
        # Caso o nó seja incluído
        branch_and_bound(no + 1, capacidade_restante - items[no].peso, valor_atual + items[no].valor)
        # Caso o nó não seja incluído
        branch_and_bound(no + 1, capacidade_restante, valor_atual)

    melhor_valor = 0
    branch_and_bound(0, capacidade, 0)
    return melhor_valor

# Exemplo de uso
itens = [Item(2, 10), Item(3, 5), Item(5, 15), Item(7, 7), Item(1, 6)]
capacidade_mochila = 10
resultado = mochila_0_1(itens, capacidade_mochila)
print("O valor máximo que pode ser colocado na mochila é:", resultado)
