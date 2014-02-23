import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class derivAx(problem.Problem):
	bases = [1,2,3,4,5,6]
	coefficients = [1,2,3,4,5,6,7,8,9]

	def generate_problem(self):
		base = random.choice(self.bases)
		coefficient = random.choice(self.coefficients)
		x = self.x
		eqn = coefficient * base ** x
		self.problem_statement = Derivative(eqn, x)