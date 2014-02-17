from django.http import Http404
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_http_methods
from django.views.decorators.gzip import gzip_page

@require_http_methods(["GET"])
@gzip_page
def home(request):
    return render(request, 'index.html')