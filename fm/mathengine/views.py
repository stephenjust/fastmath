import json
import fm.mathengine.problems as problems

from django.http import Http404
from django.http import HttpResponse
from django.views.decorators.http import require_http_methods

def index(request):
    return HttpResponse("This should return a list of problem types")

@require_http_methods(["GET"])
def problem(request, problem_type, seed):
	pclass = problems.get_problem_class(problem_type)
	if pclass is None:
		raise Http404
	p = pclass(seed)
	return HttpResponse(json.dumps({'latex': p.get_statement(),
									'prefix': p.get_answer_prefix(),
									'postfix': p.get_answer_postfix()}))

@require_http_methods(["POST"])
def check(request, problem_type, seed):
	pclass = problems.get_problem_class(problem_type)
	if pclass is None:
		raise Http404
	p = pclass(seed)
	return HttpResponse(json.dumps({'correct': p.check(request.POST['input'])}))