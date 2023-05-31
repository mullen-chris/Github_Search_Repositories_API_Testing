require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Pagination - page:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_page_1) { "#{url}&page=1" }
	let(:url_page_0) { "#{url}&page=0" }	
	let(:url_page_M1) { "#{url}&page=-1" }
	let(:url_page_999) { "#{url}&page=999" }

	context "page value is empty" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url)
			expect(request.response.code).to eq('200')
		end
	end

	context "page value is valid" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url_page_1)
			expect(request.response.code).to eq('200')
		end
	end

	context "page value is zero" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url_page_0)
			expect(request.response.code).to eq('200')
		end
	end


	context "page value is negative" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url_page_M1)
			expect(request.response.code).to eq('200')
		end
	end
	
	context "page value is too large" do
		it 'returns 422 Unprocessable Content' do
			request = request_API_HTTParty(url_page_999)
			expect(request.response.code).to eq('422')
		end
	end
end
