from django.conf.urls import patterns, url

from fm.mathengine import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
	url(r'^(?P<problem_type>\w+)/(?P<seed>\d+)/$', views.problem, name='problem'),
)