require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - in:" do
	let(:regex) { /^.*[Qq]+.*$/ }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_in_name) { "#{url} in:name" }
	let(:url_qualifier_in_description) { "#{url} in:description" }
	let(:url_qualifier_in_topics) { "#{url} in:topics" }
	let(:url_qualifier_in_readme) { "#{url} in:readme" }

	context "in qualifier is name" do
		it 'returns 200 Success with a list of repositories with names containing Q' do
			request = request_API_HTTParty(url_qualifier_in_name)
			expect(request.response.code).to eq('200')

			# Filter results by name
			items = JSON.parse(request.response.body)['items']
			names = filter_hash_keys(items, 'name')

			expect(names.uniq).to all(match(regex))
		end
	end

	context "in qualifier is description" do
		it 'returns 200 Success with a list of repositories with descriptions containing Q' do
			request = request_API_HTTParty(url_qualifier_in_description)
			expect(request.response.code).to eq('200')

			# Filter results by description
			items = JSON.parse(request.response.body)['items']
			descriptions = filter_hash_keys(items, 'description')

			expect(descriptions.uniq).to all(match(regex))
		end
	end

	context "in qualifier is topics" do
		it 'returns 200 Success with a list of repositories where the topics contain a substring' do
			request = request_API_HTTParty(url_qualifier_in_topics)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics = get_topics(items)

			expect(topics).to all(match(regex))
		end
	end

	# TODO - FAIL - README.md is missing or at a different URL
	context "in qualifier is readme" do
		it 'returns 200 Success with a list of repositories where the readme contains a substring' do
			request = request_API_HTTParty(url_qualifier_in_readme)
			expect(request.response.code).to eq('200')

			# Filter results by readme
			items = JSON.parse(request.response.body)['items']

			readmes = []
			items.each do |item|
				owner = item['owner']['login']
				repo = item['name']
				branch = item['default_branch']

				readme = download_README(owner, repo, branch)
				readmes.push(readme)
			end

			expect(readmes).to all(match(regex))
		end
	end
end