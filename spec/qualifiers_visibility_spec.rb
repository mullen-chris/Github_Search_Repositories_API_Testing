require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - visibility:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_is_public) { "#{url} is:public" }
	let(:url_qualifier_is_private) { "#{url} is:private" }

	context "is qualifier used to filter repositories which are public" do
		it 'returns 200 Success with a list of public repositories' do
			request = request_API_HTTParty(url_qualifier_is_public)
			expect(request.response.code).to eq('200')

			# Filter results by visibility
			items = JSON.parse(request.response.body)['items']
			visibilities = filter_hash_keys(items, 'visibility')

			expect(visibilities.uniq).to eq(['public'])
		end
	end

	context "is qualifier used to filter repositories which are private" do
		it 'returns 200 Success with a list of private repositories' do
			request = request_API_HTTParty(url_qualifier_is_private)
			expect(request.response.code).to eq('200')

			# Filter results by visibility
			items = JSON.parse(request.response.body)['items']
			visibilities = filter_hash_keys(items, 'visibility')

			expect(visibilities.uniq).to eq(['private'])
		end
	end
end