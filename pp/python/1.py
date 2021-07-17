
a = [ {"indeks" : "mi08293", "ime" : "Dusan"}, { "indeks" : "mi12312", "ime" : "ALuka"}]

a=  sorted(a, key = lambda a:  a['indeks'])
print(a)