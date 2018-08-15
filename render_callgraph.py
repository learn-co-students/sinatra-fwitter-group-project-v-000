from graphviz import Source

f = open('callgraph.gv', 'r')
temp = f.read()
f.close()
s = Source(temp, filename="test.gv", format="png")
s.render('find_by_slug_callgraph.gv', view=True) 
