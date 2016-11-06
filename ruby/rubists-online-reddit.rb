require 'uri'
require 'net/http'
require 'net/https'
require 'mechanize'
require 'json'

mechanize = Mechanize.new

while @reddit_ruby.nil? do
	begin
		@reddit_ruby = mechanize.get("http://reddit.com/r/ruby")
	rescue
		puts "Reddit is down. Trying again in 30 seconds.."
		sleep 30
	end

end

online_now = @reddit_ruby.search("//p[@class='users-online fuzzed']")[0].children[0].children[0].text
subscribed = @reddit_ruby.search("//span[@class='subscribers']")[0].children[0].children[0].text

result = {
	"online_now": online_now,
	"subscribed": subscribed
}

puts result

uri = URI.parse('http://api.myjson.com/bins/2yz52')
http = Net::HTTP.new(uri.host, uri.port)
header = {"Content-Type" => "application/json"}
request = Net::HTTP::Put.new(uri.request_uri, header)
request.body = JSON.generate(result)
response = http.request(request)
puts response.code

