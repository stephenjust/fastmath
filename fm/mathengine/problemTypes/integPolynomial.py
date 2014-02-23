import random
from sympy import *

import fm.mathengine.problemTypes.problem as problem

class integPolynomial(problem.Problem):
	terms = [1,2,3,4,5]
	exponents = [0,1,2,3,4,5,6]
	coefficients = [1,2,3,4,5,6,7,8,9]

	def generate_problem(self):
		nterms = random.choice(self.terms)
		nexponents = random.sample(self.exponents, nterms)
		polynomial = 0
		x = self.x
		for i in range(0, nterms):
			exponent = nexponents.pop(0)
			polynomial += random.choice(self.coefficients) * (exponent + 1) * x ** exponent
		self.problem_statement = Integral(polynomial, x)