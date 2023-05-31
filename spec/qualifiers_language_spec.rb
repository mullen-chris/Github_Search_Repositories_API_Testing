require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - language:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_language) { "#{url} language:RUBY" }
	let(:url_qualifier_languages) { "#{url_qualifier_language} language:JAVA" }

	context "language qualifier is RUBY" do
		it 'returns 200 Success with a list of Ruby repositories' do
			request = request_API_HTTParty(url_qualifier_language)
			expect(request.response.code).to eq('200')

			# Filter results by language
			items = JSON.parse(request.response.body)['items']
			languages = filter_hash_keys(items, 'language')

			expect(languages.uniq).to eq(['Ruby'])
		end
	end

	context "language qualifiers are RUBY and JAVA" do
		it 'returns 200 Success with a list of Ruby and Java repositories' do
			request = request_API_HTTParty(url_qualifier_languages)
			expect(request.response.code).to eq('200')

			# Filter results by language
			items = JSON.parse(request.response.body)['items']
			languages = filter_hash_keys(items, 'language')

			expect(languages.uniq.sort).to eq(['Java', 'Ruby'])
		end
	end
end