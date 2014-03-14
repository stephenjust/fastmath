import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class derivPolynomial(problem.Problem):
	terms = [1,2,3,4]
	exponents = [1,2,3,4,5,6]
	coefficients = [1,2,3,4,5,6,7,8,9]

	def generate_problem(self):
		nterms = random.choice(self.terms)
		if nterms == 1:
			nexponents = [random.choice(self.exponents)]
		else:
			nexponents = random.sample(self.exponents, nterms)
		polynomial = 0
		x = self.x
		for i in range(0, nterms):
			polynomial += random.choice(self.coefficients) * x ** nexponents.pop(0)
		self.problem_statement = Derivative(polynomial, x)