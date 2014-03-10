from sympy import *
from sympy.parsing.sympy_parser import parse_expr, standard_transformations, implicit_multiplication
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

	def get_answer_prefix(self):
		return ""

	def get_answer_postfix(self):
		return ""

	def check(self, input):
		""" Take MathML input and determine if it is the correct answer """
		if input is None:
			return False
		transformations = (standard_transformations + (implicit_multiplication,))
		converted_input = mmlparser.convert(input)
		if len(converted_input.strip()) == 0:
			return False
		try:
			parsed_input = parse_expr(converted_input, transformations=transformations)
		except SyntaxError:
			print('Sympy failed to parse the user\'s input: %s' % converted_input)
			return False
		if expand(parsed_input) == expand(self.problem_statement.doit()):
			return True
		else:
			return False
