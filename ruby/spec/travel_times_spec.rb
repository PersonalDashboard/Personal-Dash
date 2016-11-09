require_relative 'spec_helper'
require_relative '../gmaps-travel-times.rb'
describe "TravelTimes" do

	let(:times) {TravelTimes.new}

	it "produces a result hash" do
		expect(times.result_hash).to be_a_kind_of(Hash)
	end

	it "posts to current bin" do
		expect(times.post_to_current_bin).to eq("200");
	end

	it "posts to log bin" do
		expect(times.post_to_log_bin).to eq("200");
	end
end