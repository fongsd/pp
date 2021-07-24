import constraint

problem = constraint.Problem()

problem.addVariable("x", range(1, 91))
problem.addVariable("y", range(2, 60, 2))
problem.addVariable("z", [i * i for i in range(1, 10)])

problem.addConstraint(lambda x, z: x >= z, ['x', 'z'])
problem.addConstraint(lambda x, y, z: x * 2 + y * x + z <= 34, ['x', 'y', 'z'])

sol = problem.getSolutions()

for s in sol:
    print (str(s['x']) + " " + str(s['y']) + " " + str(s['z']))