require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - repo:" do
	let(:regex) { /^.*[Qq]+.*$/ }
	let(:repo) { 'pwnwiki/q' }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_repo_owner_name) { "#{url} repo:#{repo}" }

	context "repo qualifier is a particular repository name" do
		it 'returns 200 Success and a repository with the correct name' do
			request = request_API_HTTParty(url_qualifier_repo_owner_name)
			expect(request.response.code).to eq('200')

			# Filter results by repo name
			items = JSON.parse(request.response.body)['items']
			repos = filter_hash_keys(items, 'full_name')

			expect(repos).to all(match(regex))
		end
	end
end