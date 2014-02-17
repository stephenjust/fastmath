from sympy import *
from sympy.parsing.sympy_parser import parse_expr
import random

class Problem:
	"""
	Base class representing all math problems
	"""
	random_seed = 0
	problem_statement = None
	x = Symbol('x')
	
	def __init__(self, random_seed):
		random.seed(random_seed)
		self.random_seed = random_seed
		self.generate_problem()
		
	def generate_problem(self):
		"""
		Child classes should override this!
		"""
		pass
		
	def get_statement(self):
		return latex(self.problem_statement)