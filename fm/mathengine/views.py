from django.http import HttpResponse

def index(request):
    return HttpResponse("This isn't a valid problem url!")
	
def problem(request, problem_type, seed):
	return HttpResponse("You hit a problem page! We should resolve this to a problem.")