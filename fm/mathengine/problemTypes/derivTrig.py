import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class derivTrig(problem.Problem):
	coefficients = [1,2,3,4,5,6,7,8,9]
	functions = [sin, cos]

	def generate_problem(self):
		coefficient = random.choice(self.coefficients)
		coefficient2 = random.choice(self.coefficients)
		function = random.choice(self.functions)
		x = self.x
		eqn = random.choice([1, -1]) * coefficient * function(coefficient2 * x)
		self.problem_statement = Derivative(eqn, x)