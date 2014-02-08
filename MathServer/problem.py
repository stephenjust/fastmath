#!/usr/bin/python2.7

from sympy import *

class problem(object):
	""" Parent Class for all problem_types """

	coefficient_id = 0
	problem_statement = 0
	coefficient_id = 0
	def __init__(self, coefficient_id):
		self.coefficient_id = coefficient_id
		pass

	def get_statment(self):
		""" returns the problem statement as LaTeX """
		pass

	def eval_prob_statement(self):
		""" Evaluates the correct answer to the problem_statement and returns the sympy expression """
		# Can probbaly just take self.problem_statement, run it through Integrate() or whatever method 
		# used, and return it.
		# diffeq = Eq(f(x).diff(x, x) - 2*f(x).diff(x) + f(x), sin(x))
		# return Solve?(diffeq)
		
	def eval_result(self, MathInput):
		""" Checks that the inputted expresion is symbolically equal to eval_prob_statement """
		pass
              
	
	pass
