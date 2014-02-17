import json
import fm.mathengine.problems as problems

from django.http import Http404
from django.http import HttpResponse

def index(request):
    return HttpResponse("This should return a list of problem types")
	
def problem(request, problem_type, seed):
	pclass = problems.get_problem_class(problem_type)
	if pclass is None:
		raise Http404
	p = pclass(seed)
	return HttpResponse(p.get_statement())