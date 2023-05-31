require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - archived:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_archived_true) { "#{url} archived:true" }
	let(:url_qualifier_archived_false) { "#{url} archived:false" }

	context "is qualifier used to filter repositories which are archived" do
		it 'returns 200 Success with a list of archived repositories' do
			request = request_API_HTTParty(url_qualifier_archived_true)
			expect(request.response.code).to eq('200')

			# Filter results by template
			items = JSON.parse(request.response.body)['items']
			archive_urls = filter_hash_keys(items, 'archive_url')

			# Check for blank archive_urls
			expect(archive_urls).to_not eq(archive_urls.reject { |a| a.empty? })
		end
	end

	context "is qualifier used to filter repositories which are not archived" do
		it 'returns 200 Success with a list of not archived repositories' do
			request = request_API_HTTParty(url_qualifier_archived_false)
			expect(request.response.code).to eq('200')

			# Filter results by template
			items = JSON.parse(request.response.body)['items']
			archive_urls = filter_hash_keys(items, 'archive_url')

			# Check for blank archive_urls
			expect(archive_urls).to eq(archive_urls.reject { |a| a.empty? })
		end
	end
end