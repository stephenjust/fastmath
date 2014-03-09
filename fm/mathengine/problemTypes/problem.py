from sympy import *
from sympy.parsing.sympy_parser import parse_expr
import random
import fm.mathengine.mmlparser as mmlparser

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
	
	def check(self, input):
		""" Take MathML input and determine if it is the correct answer """
		if input is None:
			return False
		converted_input = mmlparser.convert(input)
		try:
			parsed_input = parse_expr(converted_input)
		except SyntaxError:
			print('Sympy failed to parse the user\'s input')
			return False
		if expand(parsed_expr) == expand(self.problem_statement.doit()):
			return True
		else:
			return False
