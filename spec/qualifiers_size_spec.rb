require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - size:" do
	let(:size) { 100 }
	let(:size2) { 1000 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_size_equal) { "#{url} size:#{size}" }
	let(:url_qualifier_size_greater) { "#{url} size:>#{size}" }
	let(:url_qualifier_size_less) { "#{url} size:<#{size}" }
	let(:url_qualifier_size_range) { "#{url} size:#{size}..#{size2}" }

	# TODO - FAIL - size is not always exact
	context "size qualifier used to filter results which equal the repo size in kb" do
		it 'returns 200 Success with a list of repositories of the correct size' do
			request = request_API_HTTParty(url_qualifier_size_equal)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by size
			sizes = filter_hash_keys(items, 'size')

			expect(sizes.uniq.sort).to eq([size])
		end
	end

	context "size qualifier used to filter results which are greater than the repo size in kb" do
		it 'returns 200 Success with a list of repositories of the correct size' do
			request = request_API_HTTParty(url_qualifier_size_greater)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by size
			sizes = filter_hash_keys(items, 'size')

			expect(sizes.min).to be > size
		end
	end

	context "size qualifier used to filter results which are less than the repo size in kb" do
		it 'returns 200 Success with a list of repositories of the correct size' do
			request = request_API_HTTParty(url_qualifier_size_less)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by size
			sizes = filter_hash_keys(items, 'size')

			expect(sizes.max).to be < size
		end
	end

	context "size qualifier used to filter results whose repo sizes are within a range" do
		it 'returns 200 Success with a list of repositories of the correct size' do
			request = request_API_HTTParty(url_qualifier_size_range)
			expect(request.response.code).to eq('200')

			items = JSON.parse(request.response.body)['items']

			# Filter results by size
			sizes = filter_hash_keys(items, 'size')

			expect(sizes.min).to be > size
			expect(sizes.max).to be < size2
		end
	end
end