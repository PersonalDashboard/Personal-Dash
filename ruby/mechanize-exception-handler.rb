require 'mechanize'

mechanize = Mechanize.new

while @imgur.nil? do
	begin
		@imgur = mechanize.get("https://imgur.com")
	rescue
		puts "No results returned. Trying again in 30 seconds.."
		sleep 10
	end

end

puts "Valid results returned"
