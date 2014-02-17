import sys
from fm.mathengine.problemTypes.derivPolynomial import *

def get_problem_class(str):
	try:
		return getattr(sys.modules[__name__], str)
	except AttributeError:
		return None
