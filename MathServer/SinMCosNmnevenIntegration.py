#!/usr/bin/python2.7

from problem import *
import random

class SinMCosNmnevenIntegration(problem):
	""" Expressions of the form \int (sin^m x * cos^n x) dx """

	#Coefficient sets H, K
	Mset = [2, 4, 6]
	Nset = [2, 4, 6 ]
	
	x = Symbol('x')
	problem_statement = 0
	correct_answer = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(SinMCosNmnevenIntegration, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		M = self.Mset[coefficient_id % 3]
		coefficient_id = int(random.random()*100 //1)
		N = self.Nset[coefficient_id % 3 ]		
		x = self.x
		self.problem_statement =  Integral( ((sin(x))**M)*((cos(x))**N)   ) ,x)
		pass
pass
	
	  
