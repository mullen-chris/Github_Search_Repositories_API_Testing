require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Pagination - per_page:" do
	let(:default_results_per_page) { 30 }
	let(:max_results_per_page) { 100 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_per_page_1) { "#{url}&per_page=1" }
	let(:url_per_page_0) { "#{url}&per_page=0" }
	let(:url_per_page_M1) { "#{url}&per_page=-1" }
	let(:url_per_page_101) { "#{url}&per_page=101" }

	context "per_page value is valid" do
		it 'returns 200 Success with default per_page value' do
			request = request_API_HTTParty(url_per_page_1)
			expect(request.response.code).to eq('200')
			expect(JSON.parse(request.response.body)['items'].size).to eq(1)
		end
	end

	context "per_page value is empty" do
		it 'returns 200 Success with default per_page value' do
			request = request_API_HTTParty(url)
			expect(request.response.code).to eq('200')
			expect(JSON.parse(request.response.body)['items'].size).to eq(default_results_per_page)
		end
	end

	context "per_page value is zero" do
		it 'returns 200 Success with default per_page value' do
			request = request_API_HTTParty(url_per_page_0)
			expect(request.response.code).to eq('200')
			expect(JSON.parse(request.response.body)['items'].size).to eq(default_results_per_page)
		end
	end

	context "per_page value is negative" do
		it 'returns 200 Success with default per_page value' do
			request = request_API_HTTParty(url_per_page_M1)
			expect(request.response.code).to eq('200')
			expect(JSON.parse(request.response.body)['items'].size).to eq(default_results_per_page)
		end
	end

	context "per_page value is too large" do
		it 'returns 200 Success with maximum per_page value' do
			request = request_API_HTTParty(url_per_page_101)
			expect(request.response.code).to eq('200')
			expect(JSON.parse(request.response.body)['items'].size).to eq(max_results_per_page)
		end
	end
end
