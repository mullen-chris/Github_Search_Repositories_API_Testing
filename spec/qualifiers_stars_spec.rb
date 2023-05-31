require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - stars:" do
	let(:stars) { 10 }
	let(:stars2) { 20 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_stars_equal) { "#{url} stars:#{stars}" }
	let(:url_qualifier_stars_greater) { "#{url} stars:>#{stars}" }
	let(:url_qualifier_stars_less) { "#{url} stars:<#{stars}" }
	let(:url_qualifier_stars_range) { "#{url} stars:#{stars}..#{stars2}" }

	context "stars qualifier used to filter results have the same number of stars" do
		it 'returns 200 Success with a list of repositories with the correct stars count' do
			request = request_API_HTTParty(url_qualifier_stars_equal)
			expect(request.response.code).to eq('200')

			# Filter results by stargazers_count
			items = JSON.parse(request.response.body)['items']
			stars_counts = filter_hash_keys(items, 'stargazers_count')

			expect(stars_counts.uniq).to eq([stars])
		end
	end

	context "stars qualifier used to filter results which have more stars than queried" do
		it 'returns 200 Success with a list of repositories with the correct stars count' do
			request = request_API_HTTParty(url_qualifier_stars_greater)
			expect(request.response.code).to eq('200')

			# Filter results by stargazers_count
			items = JSON.parse(request.response.body)['items']
			stars_counts = filter_hash_keys(items, 'stargazers_count')

			expect(stars_counts.min).to be >= stars
		end
	end

	context "stars qualifier used to filter results which have less stars than queried" do
		it 'returns 200 Success with a list of repositories with the correct stars count' do
			request = request_API_HTTParty(url_qualifier_stars_less)
			expect(request.response.code).to eq('200')

			# Filter results by stargazers_count
			items = JSON.parse(request.response.body)['items']
			stars_counts = filter_hash_keys(items, 'stargazers_count')

			expect(stars_counts.max).to be <= stars
		end
	end

	context "stars qualifier used to filter results whose repo stars counts are within a range" do
		it 'returns 200 Success with a list of repositories with the correct stars count' do
			request = request_API_HTTParty(url_qualifier_stars_range)
			expect(request.response.code).to eq('200')

			# Filter results by stargazers_count
			items = JSON.parse(request.response.body)['items']
			stars_counts = filter_hash_keys(items, 'stargazers_count')

			expect(stars_counts.min).to be >= stars
			expect(stars_counts.max).to be <= stars2
		end
	end
end