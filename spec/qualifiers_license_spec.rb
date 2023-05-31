require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - licence:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_license) { "#{url} license:apache-2.0" }
	let(:url_qualifier_licenses) { "#{url_qualifier_license} license:mit" }

	context "license qualifier is a particular license" do
		it 'returns 200 Success with a list of relevant repos' do
			request = request_API_HTTParty(url_qualifier_license)
			expect(request.response.code).to eq('200')

			# Filter results by license
			items = JSON.parse(request.response.body)['items']
			licenses = filter_hash_keys2(items, 'license', 'key')

			expect(licenses.uniq).to eq(['apache-2.0'])
		end
	end

	context "license qualifiers are two particular licenses" do
		it 'returns 200 Success with a list of relevant repos' do
			request = request_API_HTTParty(url_qualifier_licenses)
			expect(request.response.code).to eq('200')

			# Filter results by license
			items = JSON.parse(request.response.body)['items']
			licenses = filter_hash_keys2(items, 'license', 'key')

			expect(licenses.uniq.sort).to eq(['apache-2.0', 'mit'])
		end
	end
end