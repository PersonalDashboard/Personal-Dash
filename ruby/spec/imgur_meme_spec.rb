require_relative 'spec_helper'
require_relative '../imgur-meme.rb'
describe "ImgurMeme" do

	let(:meme) {ImgurMeme.new}

	it "receives an imgur link" do
		expect(meme.url).to include('imgur')
	end
end