require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - forks:" do
	let(:forks) { 10 }
	let(:forks2) { 20 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_forks_equal) { "#{url} forks:#{forks}" }
	let(:url_qualifier_forks_greater) { "#{url} forks:>#{forks}" }
	let(:url_qualifier_forks_less) { "#{url} forks:<#{forks}" }
	let(:url_qualifier_forks_range) { "#{url} forks:#{forks}..#{forks2}" }

	context "forks qualifier used to filter results which equal the number of forks on the repo" do
		it 'returns 200 Success with a list of repositories with the correct fork counts' do
			request = request_API_HTTParty(url_qualifier_forks_equal)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by forks
			forks_counts = filter_hash_keys(items, 'forks')

			expect(forks_counts.uniq).to eq([forks])
		end
	end

	context "forks qualifier used to filter results which have greater than the number of forks on the repo" do
		it 'returns 200 Success with a list of repositories with the correct fork counts' do
			request = request_API_HTTParty(url_qualifier_forks_greater)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']
			
			# Filter results by forks
			forks_counts = filter_hash_keys(items, 'forks')

			expect(forks_counts.min).to be >= forks
		end
	end

	context "forks qualifier used to filter results which have less than the number of forks on the repo" do
		it 'returns 200 Success with a list of repositories with the correct fork counts' do
			request = request_API_HTTParty(url_qualifier_forks_less)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by forks
			forks_counts = filter_hash_keys(items, 'forks')

			expect(forks_counts.max).to be <= forks
		end
	end

	# TODO - FAIL - Upper Limit not respected for forks
	context "forks qualifier used to filter results whose repo forks are within a range" do
		it 'returns 200 Success with a list of repositories with the correct fork counts' do
			request = request_API_HTTParty(url_qualifier_forks_range)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by forks
			forks_counts = filter_hash_keys(items, 'forks')

			expect(forks_counts.min).to be >= forks
			expect(forks_counts.max).to be <= forks2
		end
	end
end