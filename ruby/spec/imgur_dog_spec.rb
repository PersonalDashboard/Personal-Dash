require_relative 'spec_helper'
require_relative '../imgur-dog.rb'
describe "ImgurDog" do

	let(:dog) {ImgurDog.new}

	it "receives an imgur link" do
		expect(dog.url).to include('imgur')
	end
end