import xlrd

arq = xlrd.open_workbook('C:\\Users\\guilh\\Documentos\\GitHub\\Metodos_Numericos\\Optimizacao\\Programação Inteira\\prob_mochila.xlsx')
plan = arq.sheet_by_name('instancias')
cap = arq.sheet_by_name('capacidade')

n = len(plan.row_values(0))

class Item:
    def __init__(self, peso, valor):
        self.peso = peso
        self.valor = valor

    def __str__(self):
        return f"Item(peso={self.peso}, valor={self.valor})"

def mochila_0_1(items, capacidade):
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

    def branch_and_bound(no, capacidade_restante, valor_atual, itens_selecionados_temp):
        nonlocal melhor_valor
        if capacidade_restante < 0:
            return
        if no == len(items):
            if valor_atual > melhor_valor:
                melhor_valor = valor_atual
                itens_selecionados.clear()
                itens_selecionados.extend(itens_selecionados_temp)
            return
        limite = calcular_limite(no, capacidade_restante, valor_atual)
        if limite <= melhor_valor:
            return
        # Caso o nó seja incluído
        itens_selecionados_temp.append(no)
        branch_and_bound(no + 1, capacidade_restante - items[no].peso, valor_atual + items[no].valor, list(itens_selecionados_temp))
        # Caso o nó não seja incluído
        branch_and_bound(no + 1, capacidade_restante, valor_atual, list(itens_selecionados_temp))

    melhor_valor = 0
    itens_selecionados = []
    branch_and_bound(0, capacidade, 0, [])
    return melhor_valor, itens_selecionados


itens = [0] * n
for i in range(n):
    valores = plan.col_values(i)
    itens[i] = Item(valores[0], valores[1])

capacidade_mochila = cap.cell_value(0, 0)
resultado, itens_selecionados = mochila_0_1(itens, capacidade_mochila)

print("O valor máximo que pode ser colocado na mochila é:", resultado)
print("Itens selecionados:", [str(itens[i]) for i in itens_selecionados])
