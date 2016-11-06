require 'mechanize'

mechanize = Mechanize.new

while @imgur.nil? do
	begin
		@imgur = mechanize.get("https://imgur.com/r/cats")
	rescue
		puts "No cats returned. Trying again in 30 seconds.."
		sleep 30
	end

end

def url
	"https:#{scrape_page.attributes['src']}"
end

def download
	mechanize = Mechanize.new
	if File.exists?('../../RailAware/public/dash/images/cat_image.jpg')
		File.delete('../../RailAware/public/dash/images/cat_image.jpg')
	end
	mechanize.get("https:#{scrape_page.attributes['src']}").save "../../RailAware/public/dash/images/cat_image.jpg"
end

def scrape_page
	@imgur.search("//div[@class='posts sub-gallery br5 first-child']").xpath('/html/body/div[7]/div[2]/div[1]/div[1]/div[1]/a/img')[0]

end

download
