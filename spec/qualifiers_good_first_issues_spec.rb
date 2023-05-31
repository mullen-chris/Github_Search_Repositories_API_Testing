require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - good-first-issues:" do
	let(:good_first_issues) { 10 }
	let(:good_first_issues2) { 20 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_good_first_issues_equal) { "#{url} good-first-issues:#{good_first_issues}" }
	let(:url_qualifier_good_first_issues_greater) { "#{url} good-first-issues:>#{good_first_issues}" }
	let(:url_qualifier_good_first_issues_less) { "#{url} good-first-issues:<#{good_first_issues}" }
	let(:url_qualifier_good_first_issues_range) { "#{url} good-first-issues:#{good_first_issues}..#{good_first_issues2}" }

	context "good-first-issues qualifier used to filter results have the same number of good-first-issues" do
		it 'returns 200 Success with a list of repositories with the correct good-first-issues count' do
			request = request_API_HTTParty(url_qualifier_good_first_issues_equal)
			expect(request.response.code).to eq('200')

			# Filter results by good-first-issues
			items = JSON.parse(request.response.body)['items']
			good_first_issues_counts = filter_hash_keys(items, 'good-first-issues')

			expect(good_first_issues_counts.uniq).to eq([good_first_issues])
		end
	end

	context "good-first-issues qualifier used to filter results which have more good-first-issues than queried" do
		it 'returns 200 Success with a list of repositories with the correct good-first-issues count' do
			request = request_API_HTTParty(url_qualifier_good_first_issues_greater)
			expect(request.response.code).to eq('200')

			# Filter results by good-first-issues
			items = JSON.parse(request.response.body)['items']
			good_first_issues_counts = filter_hash_keys(items, 'good-first-issues')

			expect(good_first_issues_counts.min).to be >= good_first_issues
		end
	end

	context "good-first-issues qualifier used to filter results which have less good-first-issues than queried" do
		it 'returns 200 Success with a list of repositories with the correct good-first-issues count' do
			request = request_API_HTTParty(url_qualifier_good_first_issues_less)
			expect(request.response.code).to eq('200')

			# Filter results by good-first-issues
			items = JSON.parse(request.response.body)['items']
			good_first_issues_counts = filter_hash_keys(items, 'good-first-issues')

			expect(good_first_issues_counts.max).to be <= good_first_issues
		end
	end

	context "good-first-issues qualifier used to filter results whose repo good-first-issues counts are within a range" do
		it 'returns 200 Success with a list of repositories with the correct good-first-issues count' do
			request = request_API_HTTParty(url_qualifier_good_first_issues_range)
			expect(request.response.code).to eq('200')

			# Filter results by good-first-issues
			items = JSON.parse(request.response.body)['items']
			good_first_issues_counts = filter_hash_keys(items, 'good-first-issues')

			expect(good_first_issues_counts.min).to be >= good_first_issues
			expect(good_first_issues_counts.max).to be <= good_first_issues2
		end
	end
end