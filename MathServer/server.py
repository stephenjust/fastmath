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
import libxml2
import libxslt
import sys
import types

from polynomialDifferentiation import *
from axIntegration import *
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
	return p.get_statement()
	pass

def problem_response(problem_type, random_seed, input):
	""" Uses sympy to translate mathML into sympy expression. Instatiates a problem
	type with a coefficient id. Calls p_type.evaluate_result(expr)
	return: True or False
	"""
	
	p = problem_type(random_seed)
	p.eval_prob_statement()
	return p.eval_result(input)	
	pass

def mathML_to_sympy(MathMLinput):
	return MathMLinput	
	pass

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
user_input = args.user_input
problem_type = str_to_class(args.problem_type)

#Seed the random number generator
random.seed(random_seed)
# Get the random number by 
# int(random.random()*100 // 1) 

latex_problem = get_problem(random_seed, problem_type)
# latex_problem = get_problem(random_seed, eval('problem_type'))

if user_input != "" : 
	correct = problem_response(problem_type, random_seed, mathML_to_sympy(user_input))
else:
	correct = False

#Need {random_seed, Latex_Statment, Correct}


output_dict = {'random_seed': random_seed, 'latex_statement': latex_problem, 'correct': correct}
print(json.dumps(output_dict, sort_keys=True, indent = 4))



