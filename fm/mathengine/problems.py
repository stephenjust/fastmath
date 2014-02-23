import sys
from fm.mathengine.problemTypes.derivPolynomial import *
from fm.mathengine.problemTypes.integPolynomial import *
from fm.mathengine.problemTypes.derivAx import *
from fm.mathengine.problemTypes.integAx import *

def get_problem_class(str):
	try:
		return getattr(sys.modules[__name__], str)
	except AttributeError:
		return None
