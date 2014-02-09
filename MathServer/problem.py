#!/usr/bin/python2.7

from sympy import *
from sympy.parsing.sympy_parser import parse_expr
import libxml2
import libxslt

class problem(object):
	""" Parent Class for all problem_types """

	
	problem_statement = 0
	random_seed = 0
	correct_answer = None;
	def __init__(self, random_seed):
		self.random_seed = random_seed
		pass

	def get_statment(self):
		""" returns the problem statement as LaTeX """
		pass

	def eval_prob_statement(self):
		"""Evaluates the correct answer to the problem statement and returns
		the sympy expression """
		self.correct_answer = self.problem_statement.doit()
		return self.correct_answer

	def eval_result(self, MathInput):
		"""
		Checks that the user inputted equation is symbolically equal to 
		the correct answer 
		MathInput is a string
		"""
		if MathInput is None:
			return False
		if expand(parse_expr(MathInput)) == expand(self.correct_answer):
			return True
		else:
			return False
              
	def get_statement(self):
		""" Returns the statement in LaTeX """
		return latex(self.problem_statement)
