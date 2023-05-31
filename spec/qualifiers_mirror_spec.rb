require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - mirror:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_mirror_true) { "#{url} mirror:true" }
	let(:url_qualifier_mirror_false) { "#{url} mirror:false" }

	context "is qualifier used to filter repositories which are mirrored" do
		it 'returns 200 Success with a list of mirrored repositories' do
			request = request_API_HTTParty(url_qualifier_mirror_true)
			expect(request.response.code).to eq('200')

			# Filter results by mirrored
			items = JSON.parse(request.response.body)['items']
			mirrors = filter_hash_keys(items, 'mirrored')

			expect(mirrors.uniq).to eq(['true'])
		end
	end

	context "is qualifier used to filter repositories which are not mirrored" do
		it 'returns 200 Success with a list of not mirrored repositories' do
			request = request_API_HTTParty(url_qualifier_mirror_false)
			expect(request.response.code).to eq('200')

			# Filter results by mirrored
			items = JSON.parse(request.response.body)['items']
			visibilities = filter_hash_keys(items, 'mirrored')

			expect(visibilities.uniq).to eq(['false'])
		end
	end
end