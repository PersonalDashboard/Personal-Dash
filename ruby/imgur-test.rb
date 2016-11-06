require 'mechanize'

class ImgurPhoto
	def initialize
		mechanize = Mechanize.new
		@imgur = mechanize.get("https://imgur.com/r/cats")
	end

	def url
		"https:#{scrape_page.attributes['src']}"
	end

	def download
		mechanize = Mechanize.new
		mechanize.get("https:#{scrape_page.attributes['src']}").save "top_image.jpg"
	end

	def scrape_page
		@imgur.search("//div[@class='posts']").xpath('/html/body/div[7]/div[2]/div[1]/div[1]/div[1]/a/img')[0]
	end

		
end
