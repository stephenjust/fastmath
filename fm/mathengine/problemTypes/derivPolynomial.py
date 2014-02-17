import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class derivPolynomial(problem.Problem):
	terms = [1,2,3,4,5]
	exponents = [0,1,2,3,4,5,6]
	coefficients = [1,2,3,4,5,6,7,8,9]

	def generate_problem(self):
		nterms = random.choice(self.terms)
		nexponents = random.sample(self.exponents, nterms)
		polynomial = 0
		x = self.x
		for i in range(1, nterms):
			polynomial += random.choice(self.coefficients) * x ** nexponents.pop(0)
		self.problem_statement = Derivative(polynomial)