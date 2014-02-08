#!/usr/bin/python2.7

from problem import *

class polynomialDifferentiation(problem):
	""" Expressions of the form d/dx(H x**k + H x**(K+H)) """

	#Coefficient sets H, K
	Hset = [i for i in range(0,15)]
	Kset = [i for i in range(0,6) ]

	x = Symbol('x')


	def __init__(self, coefficient_id):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(polynomialDifferentiation, self).__init__(coefficient_id)
		H = Hset[coefficient_id % 16]
		K = Kset[coefficient_id % 7 ]		
		self.problem_statement =  (x**K + H*(x**(K+H)))
		pass

	def get_statement(self)
	
	  
