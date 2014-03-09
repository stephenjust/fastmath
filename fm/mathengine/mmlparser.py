import fm.settings
import os
import io
from lxml import etree

XSLT_DIR = os.path.join(fm.settings.BASE_DIR, 'xslt')

def convert(input):
	if input is None or input == "None" or len(input) == 0: return None
	try:
		xslfile = open(os.path.join(XSLT_DIR, 'mmltex.xsl'))
	except IOError:
		print('Failed to open XSL file')
		raise
	try:
		styletree = etree.parse(xslfile)
		transform = etree.XSLT(styletree)
		inputx = etree.XML(input)
		result = transform(inputx)
	except:
		print('Failed to transform input')
		raise
	return str(result)