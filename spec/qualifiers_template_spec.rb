require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - is_template:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_template_true) { "#{url} template:true" }
	let(:url_qualifier_template_false) { "#{url} template:false" }

	context "is qualifier used to filter repositories which are templates" do
		it 'returns 200 Success with a list of template repositories' do
			request = request_API_HTTParty(url_qualifier_template_true)
			expect(request.response.code).to eq('200')

			# Filter results by template
			items = JSON.parse(request.response.body)['items']
			mirrors = filter_hash_keys(items, 'is_template')

			expect(mirrors.uniq).to eq([true])
		end
	end

	context "is qualifier used to filter repositories which are not templates" do
		it 'returns 200 Success with a list of not template repositories' do
			request = request_API_HTTParty(url_qualifier_template_false)
			expect(request.response.code).to eq('200')

			# Filter results by template
			items = JSON.parse(request.response.body)['items']
			visibilities = filter_hash_keys(items, 'is_template')

			expect(visibilities.uniq).to eq([false])
		end
	end
end