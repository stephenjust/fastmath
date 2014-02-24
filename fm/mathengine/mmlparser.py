import fm.settings
import os
import io
from lxml import etree

XSLT_DIR = os.path.join(fm.settings.BASE_DIR, 'xslt')

def convert(input):
	if input is None or input == "None" or len(input) == 0: return None
	styletree = etree.parse(open(os.path.join(XSLT_DIR, 'mmltex.xsl')))
	transform = etree.XSLT(styletree)
	inputx = etree.XML(input)
	result = transform(inputx)
	return str(result)[1:-1]