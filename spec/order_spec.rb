require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Ordering:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}&sort=forks" }
	let(:url_order_desc) { "#{url}&order=desc" }
	let(:url_order_asc) { "#{url}&order=asc" }
	let(:url_order_alphabetical) { "#{url}&order=alpha" }

	# FAIL - Ordering is not consistent especially at the lower end
	context "query is ordered by highest number of matches" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url_order_desc)
			expect(request.response.code).to eq('200')

			# Filter results by forks
			items = JSON.parse(request.response.body)['items']
			forks = filter_hash_keys(items, 'forks')

			expect(forks).to eq(forks.sort.reverse)
		end
	end

	# FAIL - Ordering is not consistent especially at the lower end
	context "query is ordered by lowest number of matches" do
		it 'returns 200 Success' do
			request = request_API_HTTParty(url_order_asc)
			expect(request.response.code).to eq('200')

			# Filter results by forks
			items = JSON.parse(request.response.body)['items']
			forks = filter_hash_keys(items, 'forks')

			expect(forks).to eq(forks.sort)
		end
	end

	# FAIL - Ordering is not consistent especially at the lower end
	context "query is ordered by default" do
		it 'returns 200 Success and ordered by highest number of matches' do
			request = request_API_HTTParty(url)
			expect(request.response.code).to eq('200')	

			# Filter results by forks
			items = JSON.parse(request.response.body)['items']
			forks = filter_hash_keys(items, 'forks')

			expect(forks).to eq(forks.sort.reverse)
		end
	end

	# FAIL - Ordering is not consistent especially at the lower end
	context "query order is invalid" do
		it 'returns 200 Success and ordered by highest number of matches' do
			request = request_API_HTTParty(url_order_alphabetical)
			expect(request.response.code).to eq('200')

			# Filter results by forks
			items = JSON.parse(request.response.body)['items']
			forks = filter_hash_keys(items, 'forks')

			expect(forks).to eq(forks.sort.reverse)
		end
	end
end
