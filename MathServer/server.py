#!/usr/bin/python2.7

import problem
import problem_types
import argparse
import random

from polynomialDifferentiation import *


""" Initializer for the Math Server. 
in(random_seed, problem_type, user_input)
		 		`MathML
out(random_seed, LaTeX problem_statment, (Bool) correct)
"""


def get_problem(random_seed, problem_type):
	""" Takes the seed, makes a coefficient_id to constructor of problem_type
	get_statement() on the problem, outputs LaTeX
	return: (coefficient_id, Latex)
	"""
	p = problem_type(random_seed)
	return p.get_statement()
	pass

def problem_response(problem_type, random_seed, MathmlInput):
	""" Uses sympy to translate mathML into sympy expression. Instatiates a problem
	type with a coefficient id. Calls p_type.evaluate_result(expr)
	return: True or False
	"""
	
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
random_seed = args.random_seed
user_input = args.user_input
problem_type = args.problem_type

#Seed the random number generator
random.seed(random_seed)
# Get the random number by 
# int(random.random()*100 // 1) 

latex_problem = get_problem(random_seed, polynomialDifferentiation)
# latex_problem = get_problem(random_seed, eval('problem_type'))

print("{"+latex_problem+"}")
