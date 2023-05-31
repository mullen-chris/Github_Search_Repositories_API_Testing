require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Sorting:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_sort_stars) { "#{url}&sort=stars" }
	let(:url_sort_forks) { "#{url}&sort=forks" }
	let(:url_sort_help_wanted_issues) { "#{url}&sort=help-wanted-issues" }
	let(:url_sort_updated) { "#{url}&sort=updated" }

	context "query is sorted by number of stars" do
		it 'returns 200 Success with results in the correct order' do
			request = request_API_HTTParty(url_sort_stars)
			expect(request.response.code).to eq('200')

			# Filter results by stargazers_count
			items = JSON.parse(request.response.body)['items']
			stars = filter_hash_keys(items, 'stargazers_count')

			expect(stars).to eq(stars.sort.reverse)
		end
	end

	# TODO - FAIL - Ordering is not consistent especially at the lower end
	context "query is sorted by number of forks" do
		it 'returns 200 Success with results in the correct order' do
			request = request_API_HTTParty(url_sort_forks)
			expect(request.response.code).to eq('200')

			# Filter results by forks
			items = JSON.parse(request.response.body)['items']
			forks = filter_hash_keys(items, 'forks')

			expect(forks).to eq(forks.sort.reverse)
		end
	end

	# TODO - FAIL - Ordering is not consistent especially at the lower end
	context "query is sorted by number of help-wanted-issues" do
		it 'returns 200 Success with results in the correct order' do
			request = request_API_HTTParty(url_sort_help_wanted_issues)
			expect(request.response.code).to eq('200')

			# Filter results by open_issues
			items = JSON.parse(request.response.body)['items']
			open_issues = filter_hash_keys(items, 'open_issues')

			expect(open_issues).to eq(open_issues.sort.reverse)
		end
	end

	# TODO - FAIL - Ordering is not consistent especially at the lower end
	context "query is sorted by updated_at" do
		it 'returns 200 Success with results in the correct order' do
			request = request_API_HTTParty(url_sort_updated)
			expect(request.response.code).to eq('200')

			# Filter results by open_issues
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'updated_at')

			expect(timestamps).to eq(timestamps.sort.reverse)
		end
	end
end
