#!/usr/bin/python2.7

from problem import *
import random

class polynomialDifferentiation(problem):
	""" Expressions of the form d/dx(H x**k + H x**(K+H)) """

	#Coefficient sets H, K
	Hset = [i for i in range(0,15)]
	Kset = [i for i in range(0,6) ]

	x = Symbol('x')
	problem_statement = 0
	correct_answer = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(polynomialDifferentiation, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		H = self.Hset[coefficient_id % 16]
		coefficient_id = int(random.random()*100 //1)
		K = self.Kset[coefficient_id % 7 ]		
		x = self.x
		self.problem_statement =  Derivative((x**K + H*(x**(K+H))),x)
		pass

	def get_statement(self):
		""" Returns the statement in LaTeX """
		return latex(self.problem_statement)
		pass
	
	def eval_prob_statement(self):
		"""Evaluates the correct answer to the problem statement and returns
		the sympy expression """
		self.correct_answer = self.problem_statement.doit()
		return self.correct_answer
		pass

	def eval_result(self, MathInput):
		""" Checks that the user inputted equation is symbolically equal to 
		the correct answer 
		MathInput is a string
		"""
		if parse_expr(MathInput) == self.correct_answer:
			return True
		else:
			return False
pass
	
	  
