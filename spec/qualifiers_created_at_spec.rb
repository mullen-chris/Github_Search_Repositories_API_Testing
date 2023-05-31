require 'rspec/autorun'
require 'date'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - created_at:" do
	let(:default_results_per_page) { 30 }
	let(:date) { '2022-01-01' }
	let(:date2) { '2022-01-08' }
	let(:date_time) { DateTime.parse(date) }
	let(:date_time2) { DateTime.parse(date2) }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_created_after) { "#{url} created:>#{date}" }
	let(:url_qualifier_created_before) { "#{url} created:<#{date}" }
	let(:url_qualifier_created_on) { "#{url} created:#{date}" }
	let(:url_qualifier_created_range) { "#{url} created:#{date}..#{date2}" }

	context "created qualifier is greater than a particular date" do
		it 'returns 200 Success with a list of repositories created after the date' do
			request = request_API_HTTParty(url_qualifier_created_after)
			expect(request.response.code).to eq('200')

			# Filter results by created_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'created_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
		end
	end

	context "created qualifier is less than a particular date" do
		it 'returns 200 Success with a list of repositories created before the date' do
			request = request_API_HTTParty(url_qualifier_created_before)
			expect(request.response.code).to eq('200')

			# Filter results by created_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'created_at')

			expect(DateTime.parse(timestamps.max)).to be < date_time
		end
	end

	context "created qualifier is on a particular date" do
		it 'returns 200 Success with a list of repositories created on the date' do
			request = request_API_HTTParty(url_qualifier_created_on)
			expect(request.response.code).to eq('200')

			# Filter results by created_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'created_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
			expect(DateTime.parse(timestamps.max)).to be < ( date_time + 1 )
		end
	end

	context "created qualifier is in a particular range" do
		it 'returns 200 Success with a list of repositories created within the range' do
			request = request_API_HTTParty(url_qualifier_created_range)
			expect(request.response.code).to eq('200')

			# Filter results by created_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'created_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
			expect(DateTime.parse(timestamps.max)).to be < ( date_time2 + 1 )
		end
	end
end