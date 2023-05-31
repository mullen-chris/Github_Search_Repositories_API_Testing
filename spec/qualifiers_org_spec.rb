require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - org:" do
	let(:query) { 'OCTOCAT' }
	let(:regex) { /^.*octocat.*$/ }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_org) { "#{url} org:#{query}" }

	context "org qualifier is a particular organization" do
		it 'returns 200 Success with a list of repositories in a organization' do
			request = request_API_HTTParty(url_qualifier_org)
			expect(request.response.code).to eq('200')

			# Filter results by repo name
			items = JSON.parse(request.response.body)['items']
			orgs = filter_hash_keys2(items, 'owner', 'organizations_url')

			expect(orgs).to all(match(regex))
		end
	end
end