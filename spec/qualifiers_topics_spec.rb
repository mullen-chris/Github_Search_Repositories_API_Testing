require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - topics:" do
	let(:topics) { 10 }
	let(:topics2) { 20 }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_topics_equal) { "#{url} topics:#{topics}" }
	let(:url_qualifier_topics_greater) { "#{url} topics:>#{topics}" }
	let(:url_qualifier_topics_less) { "#{url} topics:<#{topics}" }
	let(:url_qualifier_topics_range) { "#{url} topics:#{topics}..#{topics2}" }

	context "topics qualifier is a particular topic count" do
		it 'returns 200 Success with a list of repositories with the correct topic counts' do
			request = request_API_HTTParty(url_qualifier_topics_equal)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics_counts = get_topics_counts(items)

			expect(topics_counts.uniq).to eq([topics])
		end
	end

	context "topics qualifier used to filter results which have more topics than queried" do
		it 'returns 200 Success with a list of repositories with the correct topics count' do
			request = request_API_HTTParty(url_qualifier_topics_greater)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics_counts = get_topics_counts(items)

			expect(topics_counts.min).to be >= topics
		end
	end

	context "topics qualifier used to filter results which have less topics than queried" do
		it 'returns 200 Success with a list of repositories with the correct topics count' do
			request = request_API_HTTParty(url_qualifier_topics_less)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics_counts = get_topics_counts(items)

			expect(topics_counts.max).to be <= topics
		end
	end

	context "topics qualifier used to filter results whose repo topics counts are within a range" do
		it 'returns 200 Success with a list of repositories with the correct topics count' do
			request = request_API_HTTParty(url_qualifier_topics_range)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics_counts = get_topics_counts(items)

			expect(topics_counts.min).to be >= topics
			expect(topics_counts.max).to be <= topics2
		end
	end
end