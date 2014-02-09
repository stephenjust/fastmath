#!/usr/bin/python2.7

from problem import *
import random

class CosxIntegration(problem):
	""" Expressions of the form \int (cos(k*x)) """

	#Coefficient sets H, K
	Hset = [i for i in range(0,15)]
	Kset = [i for i in range(0,20) ]

	x = Symbol('x')
	problem_statement = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(CosxIntegration, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		H = self.Hset[coefficient_id % 16]
		coefficient_id = int(random.random()*100 //1)
		K = self.Kset[coefficient_id % 20 ]		
		x = self.x
		self.problem_statement =  Integral(cos(K*x)  ,x)
		pass

pass
	
	  
