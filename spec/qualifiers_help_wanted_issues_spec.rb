require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - help-wanted-issues:" do
	let(:help_wanted_issues) { 10 }
	let(:help_wanted_issues2) { 20 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_help_wanted_issues_equal) { "#{url} help-wanted-issues:#{help_wanted_issues}" }
	let(:url_qualifier_help_wanted_issues_greater) { "#{url} help-wanted-issues:>#{help_wanted_issues}" }
	let(:url_qualifier_help_wanted_issues_less) { "#{url} help-wanted-issues:<#{help_wanted_issues}" }
	let(:url_qualifier_help_wanted_issues_range) { "#{url} help-wanted-issues:#{help_wanted_issues}..#{help_wanted_issues2}" }

	context "help-wanted-issues qualifier used to filter results have the same number of help-wanted-issues" do
		it 'returns 200 Success with a list of repositories with the correct help-wanted-issues count' do
			request = request_API_HTTParty(url_qualifier_help_wanted_issues_equal)
			expect(request.response.code).to eq('200')

			# Filter results by help-wanted-issues
			items = JSON.parse(request.response.body)['items']
			help_wanted_issues_counts = filter_hash_keys(items, 'help-wanted-issues')

			expect(help_wanted_issues_counts.uniq).to eq([help_wanted_issues])
		end
	end

	context "help-wanted-issues qualifier used to filter results which have more help-wanted-issues than queried" do
		it 'returns 200 Success with a list of repositories with the correct help-wanted-issues count' do
			request = request_API_HTTParty(url_qualifier_help_wanted_issues_greater)
			expect(request.response.code).to eq('200')

			# Filter results by help-wanted-issues
			items = JSON.parse(request.response.body)['items']
			help_wanted_issues_counts = filter_hash_keys(items, 'help-wanted-issues')

			expect(help_wanted_issues_counts.min).to be >= help_wanted_issues
		end
	end

	context "help-wanted-issues qualifier used to filter results which have less help-wanted-issues than queried" do
		it 'returns 200 Success with a list of repositories with the correct help-wanted-issues count' do
			request = request_API_HTTParty(url_qualifier_help_wanted_issues_less)
			expect(request.response.code).to eq('200')

			# Filter results by help-wanted-issues
			items = JSON.parse(request.response.body)['items']
			help_wanted_issues_counts = filter_hash_keys(items, 'help-wanted-issues')

			expect(help_wanted_issues_counts.max).to be <= help_wanted_issues
		end
	end

	context "help-wanted-issues qualifier used to filter results whose repo help-wanted-issues counts are within a range" do
		it 'returns 200 Success with a list of repositories with the correct help-wanted-issues count' do
			request = request_API_HTTParty(url_qualifier_help_wanted_issues_range)
			expect(request.response.code).to eq('200')

			# Filter results by help-wanted-issues
			items = JSON.parse(request.response.body)['items']
			help_wanted_issues_counts = filter_hash_keys(items, 'help-wanted-issues')

			expect(help_wanted_issues_counts.min).to be >= help_wanted_issues
			expect(help_wanted_issues_counts.max).to be <= help_wanted_issues2
		end
	end
end