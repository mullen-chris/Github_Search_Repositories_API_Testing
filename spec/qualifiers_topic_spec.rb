require 'rspec/autorun'
require 'date'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - topics:" do
	let(:query) { 'algorithm' }
	let(:regex) { /^.*algorithm.*$/ }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_topic) { "#{url} topic:#{query}" }

	context "topic qualifier is a particular topic" do
		it 'returns 200 Success with a list of repositories with the correct topic' do
			request = request_API_HTTParty(url_qualifier_topic)
			expect(request.response.code).to eq('200')

			# Filter results by topics
			items = JSON.parse(request.response.body)['items']
			topics = get_topics(items)

			expect(topics).to all(match(regex))
		end
	end
end