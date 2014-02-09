#!/usr/bin/python2.7

from problem import *
import random

class HxexpKxIntegration(problem):
	""" Expressions of the form \int ( x*H*exp**(K*x)) """

	#Coefficient sets H, K
	Hset = [i for i in range(-1,15)]
	Kset = [i for i in range(-1,6) ]

	x = Symbol('x')
	problem_statement = 0
	correct_answer = 0

	def __init__(self, random_seed):
		"""Initializes the problem statement d/dx(H x**K + H x**(K+H) ) """
		super(HxexpKxIntegration, self).__init__(random_seed)
		coefficient_id = int(random.random()*100 //1)
		H = self.Hset[coefficient_id % 16]
		coefficient_id = int(random.random()*100 //1)
		K = self.Kset[coefficient_id % 7 ]		
		x = self.x
		self.problem_statement =  Integral(x*H*exp(K*x)) ,x)
		pass

pass
	
	  
