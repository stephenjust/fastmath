#!/usr/bin/python2.7

from problem import *
from sympy.parsing.sympy_parser import parse_expr
import random
from sympy import *

class polynomialDifferentiation(problem):
	""" Expressions of the form d/dx(H x**k + H x**(K+H)) """

	#Coefficient sets H, K
	Hset = [i for i in range(0,5)]
	Kset = [i for i in range(0,6) ]

	x = Symbol('x')
	problem_statement = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(polynomialDifferentiation, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		H = self.Hset[coefficient_id % len(self.Hset)]
		coefficient_id = int(random.random()*100 //1)
		K = self.Kset[coefficient_id % len(self.Kset) ]		
		x = self.x
		self.problem_statement =  Derivative(( x**K + H*(x**(K+H)) ) ,x)

	def eval_result(self, MathInput):
		"""
		Checks that the user inputted equation is symbolically equal to 
		the correct answer 
		MathInput is a string
		"""
		try:
			print MathInput
			if MathInput is None:
				return False
			if expand(parse_expr(MathInput)) == expand(self.correct_answer):
				return True
			else:
				return False
		except:
			return False
	  
