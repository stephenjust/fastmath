#!/usr/bin/python2.7
"""
Python Math Server

inputs: random seed, problem type, user input
outputs: random seed, question, correct answer
"""


import problem
import problem_types
import argparse
import random
import sys
import types

from polynomialDifferentiation import *
from axIntegration import *
from axDiff import *
from CosxIntegration import *
import simplejson as json


def str_to_class(field):
    try:
        identifier = getattr(sys.modules[__name__], field)
    except AttributeError:
        raise NameError("%s doesn't exist." % field)
    if isinstance(identifier, (types.ClassType, types.TypeType)):
        return identifier
    raise TypeError("%s is not a class." % field)

def get_problem(random_seed, problem_type):
	""" Takes the seed, makes a coefficient_id to constructor of problem_type
	get_statement() on the problem, outputs LaTeX
	return: (coefficient_id, Latex)
	"""
	p = problem_type(random_seed)
	return p

def problem_response(p, input_val):
	""" Uses sympy to translate mathML into sympy expression. Instatiates a problem
	type with a coefficient id. Calls p_type.evaluate_result(expr)
	return: True or False
	"""
	if p is None: return None
	p.eval_prob_statement()
	return p.eval_result(input_val)	

def parse_math_ml(text):
	try:
		if text is None or text == "None" or len(text) == 0: return None
		styledoc = libxml2.parseFile("/srv/http/fastmath/MathServer/xslt/mmltex.xsl")
		style = libxslt.parseStylesheetDoc(styledoc)
		doc = libxml2.parseFile(text);
		result = style.applyStylesheet(doc, None)
		output = style.saveResultToString(result)
		style.freeStylesheet()
		doc.freeDoc()
		result.freeDoc()
		return output[1:-1]
	except:
		return None;

parser = argparse.ArgumentParser(description = 'Math Server for Fast Math')
parser.add_argument('--random-seed', type=int, help='Random seed value')
parser.add_argument('--problem-type', type=str, help='Problem type')
parser.add_argument('--user-input', type=str, help='User input')

args = parser.parse_args()

#print(args.random_seed)
#Variables as a result of this parser:
# random_seed
# userinput
# problem_type

random_seed = int(args.random_seed)
user_input = str(args.user_input)
problem_type = str_to_class(args.problem_type)

#Seed the random number generator
random.seed(random_seed)
# Get the random number by 
# int(random.random()*100 // 1) 

prb = get_problem(random_seed, problem_type)
latex_problem = prb.get_statement()
# latex_problem = get_problem(random_seed, eval('problem_type'))

if user_input is not None and user_input != "" : 
	correct = problem_response(prb, parse_math_ml(user_input))
else:
	correct = False
#Need {random_seed, Latex_Statment, Correct}


output_dict = {'random_seed': random_seed, 'latex_statement': latex_problem, 'correct': correct, 'parsed_input': parse_math_ml(user_input), 'input': user_input}
print(json.dumps(output_dict, sort_keys=True))



