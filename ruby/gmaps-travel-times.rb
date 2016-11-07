require 'uri'
require 'net/http'
require 'net/https'
require 'mechanize'
require 'json'

mechanize = Mechanize.new

full_route = nil;
while @gmaps.nil? && full_route.nil? do
	begin
		mechanize.get("http://www.bing.com/?cc=us") # Navigate to US version of bing to ensure proper locale
		@gmaps = mechanize.get("http://www.bing.com/search?q=161+lawn+ave%2C+32084+to+10302+Deerwood+Park+Blvd%2C+32256&go=Submit&qs=n&form=QBLH&pq=161+lawn+ave%2C+32084&sc=0-19&sp=-1&sk=&cvid=94AC1BB6A3A44384BEFBA6FFC61A0134")
		@gmaps_two = mechanize.get("http://www.bing.com/search?q=Target%2C%2032250%20to%2010302%20Deerwood%20Park%20Blvd%2C%2032256&qs=n&form=QBRE&pq=target%2C%2032250%20to%2010302%20deerwood%20park%20blvd%2C%2032256&sc=0-46&sp=-1&sk=&cvid=15B3F2E5DC5B4D4B8F3609B647AAEEB5")
		@gmaps_three = mechanize.get("http://www.bing.com/search?q=Gate%2C%2032081%20to%2010302%20Deerwood%20Park%20Blvd%2C%2032256&qs=n&form=QBRE&pq=gate%2C%2032081%20to%2010302%20deerwood%20park%20blvd%2C%2032256&sc=0-46&sp=-1&sk=&cvid=D151830DE4734E53BE5A33F64041C963")
		@gmaps_four = mechanize.get("http://www.bing.com/search?q=Avenues%20Mall%20to%2010302%20Deerwood%20Park%20Blvd%2C%2032256&qs=n&form=QBRE&pq=avenues%20mall%20to%2010302%20deerwood%20park%20blvd%2C%2032256&sc=0-47&sp=-1&sk=&cvid=7288DE87575E41B5A3B3555956EC8F8D")

		full_time = @gmaps.search("//p[@data-tag='drMins']")[0].children[0].text
		full_route = @gmaps.search("[@class='drTitleText drViaDesc']")[0].children.text

		beach_time = @gmaps_two.search("//p[@data-tag='drMins']")[0].children[0].text
		beach_route = @gmaps_two.search("[@class='drTitleText drViaDesc']")[0].children.text

		b_time = @gmaps_three.search("//p[@data-tag='drMins']")[0].children[0].text
		b_route = @gmaps_three.search("[@class='drTitleText drViaDesc']")[0].children.text

		southside_time = @gmaps_four.search("//p[@data-tag='drMins']")[0].children[0].text
		southside_route = @gmaps_four.search("[@class='drTitleText drViaDesc']")[0].children.text
	rescue
		puts "Bing is down. Trying again in 30 seconds.."
		sleep 30
	end

end

# response = Net::HTTP.get_response(URI.parse('https://api.myjson.com/bins/49kdc'))

result = {"#{Time.now.to_i}": {
"time": Time.now.to_i,
"full_route":{"route": full_route, "time": full_time},
"beach_route":{"route": beach_route, "time": beach_time},
"9b_route":{"route": b_route, "time": b_time},
"southside_route":{"route": southside_route, "time": southside_time}
}}
puts result


# Post to current status bin
uri = URI.parse('http://api.myjson.com/bins/49kdc')
http = Net::HTTP.new(uri.host, uri.port)
header = {"Content-Type" => "application/json"}
request = Net::HTTP::Put.new(uri.request_uri, header)
request.body = JSON.generate(result)
response = http.request(request)
puts response.code

# Add status to log bin
uri = URI.parse('https://api.myjson.com/bins/5aedq')
log = Net::HTTP.get(uri)
log_result = JSON.generate(result)[1...-1]
log_result.insert(0, ',')
log.insert(log.length - 1, log_result)
puts log
uri = URI.parse('http://api.myjson.com/bins/5aedq')
http = Net::HTTP.new(uri.host, uri.port)
header = {"Content-Type" => "application/json"}
request = Net::HTTP::Put.new(uri.request_uri, header)
request.body = log
response = http.request(request)
puts response.code

