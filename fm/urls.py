from django.conf.urls import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'fm.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
	url(r'^$', 'fm.views.home', name='home'),
    url(r'^math/', include('fm.mathengine.urls')),
) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
