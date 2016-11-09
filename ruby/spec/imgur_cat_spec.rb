require_relative 'spec_helper'
require_relative '../imgur-cat.rb'
describe "ImgurCat" do

	let(:cat) {ImgurCat.new}

	it "receives an imgur link" do
		expect(cat.url).to include('imgur')
	end
end