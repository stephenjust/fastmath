import random
import json

from django.http import Http404
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_http_methods
from django.views.decorators.gzip import gzip_page
from django.views.decorators.csrf import ensure_csrf_cookie

@require_http_methods(["GET"])
@gzip_page
def home(request):
	game = {'url': "/game/",
			'seed': random.randint(1000, 99999999999)}
	return render(request, 'index.html', {'game': game})

@require_http_methods(["GET"])
@gzip_page
def about(request):
	return render(request, 'about.html')

@require_http_methods(["POST"])
@gzip_page
@ensure_csrf_cookie
def play(request):
	game = {'url': "/game/",
			'seed': request.POST['seed'],
			'end_url': "/end/",
			'types': json.dumps(['derivPolynomial',
								 'integPolynomial',
								 'derivAx',
								 'integAx',
								 'derivTrig',
								 'integTrig',
								 'derivLn'])}
	return render(request, 'game.html', {'game': game})

@require_http_methods(["POST"])
@gzip_page
def end(request):
	game = {'url': "/game/",
			'seed': request.POST['seed'],
			'score': int(request.POST['score']),
			'next_seed': random.randint(1000, 99999999999)}
	return render(request, 'end.html', {'game': game})