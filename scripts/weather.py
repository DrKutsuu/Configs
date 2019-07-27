
import urllib.request
from html.parser import HTMLParser
import hashlib

LOCATION_CODE="2653822"

#"b'wr-date'" is a bytes object (Python 3)

class WeatherParser(HTMLParser):
	roughItems = ['wr-date','wr-day__details']
	keyItems = ["wr-date","wr-date__long__month","wr-date__longish__dotm", "wr-day__details-container","wr-value--temperature "]

	#Dict
	retrievedData = {}

	resultData = {}

	#Hold the current scope tag
	tagHandle = None

	def tag_content(self, asciiString):
		self.tagHandle = asciiString
		print("Tagged: "+asciiString)

	#Override methods
	def handle_starttag(self, tag, attrs: tuple):
		#print(tag)
		#print("attrs: "+str(attrs))

		for tup in attrs:
			thisTag = tup[0]
			if thisTag == "class":
				thisClass = str(tup[1])
				#asciiString = str(thisClass.encode('ascii','replace'))

				tag = False
				for roughItem in self.roughItems:
					if (roughItem in thisClass) :
						#tag = True
						continue

				for keyItem in self.keyItems:
					if (keyItem == thisClass) :
						tag = True
						continue

				if tag:
					self.tag_content(thisClass)

					#self.tagHandle = thisClass
					#print("Tagged: "+thisClass)

	def handle_data(self, data):
		if (self.tagHandle is not None):
			#hashedHandle = hashlib.md5(str(self.tagHandle)).hexdigest()

			self.resultData[self.tagHandle] = str(data).encode('ascii','ignore')

	def handle_endtag(self, tag):
		self.tagHandle = None

	def get_temp():
		pass

weatherResponse = urllib.request.urlopen("https://www.bbc.co.uk/weather/0/"+LOCATION_CODE)
html = weatherResponse.read()
wp = WeatherParser()
wp.feed(str(html))


print("\nResults:\n")
for key in wp.resultData:
	print("Result: {"+key+":" + wp.resultData[key]+"}")

#wp.retrievedData['']
