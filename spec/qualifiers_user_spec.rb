require 'rspec/autorun'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - user:" do
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
		let(:user) { 'defunkt' }
	let(:url_qualifier_user) { "#{url} user:#{user}" }

	context "user qualifier is a particular user" do
		it "returns 200 Success with a list of repositories created by a particular user" do
			request = request_API_HTTParty(url_qualifier_user)
			expect(request.response.code).to eq('200')

			users = []
			JSON.parse(request.response.body)['items'].each do |item|
				users.push(item['owner']['login'])
			end

			expect(users.uniq.sort).to eq([user])
		end
	end
end