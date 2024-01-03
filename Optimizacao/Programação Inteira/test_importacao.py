import xlrd

arq = xlrd.open_workbook('C:\\Users\\guilh\\Documentos\\GitHub\\Metodos_Numericos\\Optimizacao\\Programação Inteira\\prob_mistura.xlsx')
plan = arq.sheet_by_name('instancias')

n = len(plan.row_values(0))


##itens = [Item(2, 10), Item(3, 5), Item(5, 15), Item(7, 7), Item(1, 6)]





