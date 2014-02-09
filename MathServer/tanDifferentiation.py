#!/usr/bin/python2.7

from problem import *
from sympy.parsing.sympy_parser import parse_expr
from sympy import *
import random

class tanDifferentiation(problem):
	""" Expressions of the form \ddx (Hsin(kx)) """

	#Coefficient sets H, K
	Hset = [i for i in range(0,7)]
	Kset = [i for i in range(0,6) ]

	x = Symbol('x')
	problem_statement = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(tanDifferentiation, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		H = self.Hset[coefficient_id % len(self.Hset)]
		coefficient_id = int(random.random()*100 //1)
		K = self.Kset[coefficient_id % len(self.Kset) ]		
		x = self.x
		self.problem_statement =  Derivative(H*tan(K*x))



	

	
	  
