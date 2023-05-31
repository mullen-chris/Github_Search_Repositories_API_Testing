require 'rspec/autorun'
require_relative 'spec_helper'

# TODO - followers_url leads to the user's follower's, not the repo's followers so there's nothing to compare
RSpec.describe "GET /search/repositories Qualifiers - followers:" do
	# let(:follower) { 1 }
	# let(:follower2) { 5 }
	# let(:query) { 'Q' }
	# let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	# let(:url_qualifier_follower_equal) { url + ' followers:' + follower.to_s }
	# let(:url_qualifier_follower_greater) { url + ' followers:>' + follower.to_s }
	# let(:url_qualifier_follower_less) { url + ' followers:<' + follower.to_s }
	# let(:url_qualifier_follower_range) { url + ' followers:' + follower.to_s + '..' + follower2.to_s }

	# context "followers qualifier used to filter results have the same number of followers" do
	# 	it 'returns 200 Success with a list of repositories with the correct follower count' do
	# 		request = request_API_HTTParty(url_qualifier_follower_equal)
	# 		expect(request.response.code).to eq('200')

	# 		# Filter results by followers
	# 		items = JSON.parse(request.response.body)['items']
	# 		followers = filter_hash_keys2(items, 'owner', 'followers_url')

	# 		expect(followers.count).to eq(follower)
	# 	end
	# end

	# context "followers qualifier used to filter results which have more followers than queried" do
	# 	it 'returns 200 Success with a list of repositories with the correct follower count' do
	# 		request = request_API_HTTParty(url_qualifier_follower_greater)
	# 		expect(request.response.code).to eq('200')

	# 		# Filter results by followers
	# 		items = JSON.parse(request.response.body)['items']
	# 		followers = filter_hash_keys2(items, 'owner', 'followers_url')

	# 		expect(followers.min).to be > follower
	# 	end
	# end

	# context "followers qualifier used to filter results which have less followers than queried" do
	# 	it 'returns 200 Success with a list of repositories with the correct follower count' do
	# 		request = request_API_HTTParty(url_qualifier_follower_less)
	# 		expect(request.response.code).to eq('200')

	# 		# Filter results by followers
	# 		items = JSON.parse(request.response.body)['items']
	# 		followers = filter_hash_keys2(items, 'owner', 'followers_url')

	# 		expect(followers.max).to be < follower
	# 	end
	# end

	# context "followers qualifier used to filter results whose repo follower counts are within a range" do
	# 	it 'returns 200 Success with a list of repositories with the correct follower count' do
	# 		request = request_API_HTTParty(url_qualifier_follower_range)
	# 		expect(request.response.code).to eq('200')

	# 		# Filter results by followers
	# 		items = JSON.parse(request.response.body)['items']
	# 		followers = filter_hash_keys2(items, 'owner', 'followers_url')

	# 		expect(followers.min).to be > follower
	# 		expect(followers.max).to be < follower2
	# 	end
	# end
end