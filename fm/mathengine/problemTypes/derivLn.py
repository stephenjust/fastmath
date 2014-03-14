import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class derivLn(problem.Problem):
	coefficients = [1,2,3,4,5,6,7,8,9]

	def generate_problem(self):
		coefficient = random.choice(self.coefficients)
		coefficient2 = random.choice(self.coefficients)
		x = self.x
		eqn = coefficient * ln(coefficient2 * x)
		self.problem_statement = Derivative(eqn, x)