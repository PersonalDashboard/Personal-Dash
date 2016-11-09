require_relative 'spec_helper'
require_relative '../imgur-pun.rb'
describe "ImgurPun" do

	let(:pun) {ImgurPun.new}

	it "receives an imgur link" do
		expect(pun.url).to include('imgur')
	end
end