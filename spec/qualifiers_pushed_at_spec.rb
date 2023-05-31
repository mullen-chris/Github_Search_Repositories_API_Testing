require 'rspec/autorun'
require 'date'
require_relative 'spec_helper'

RSpec.describe "GET /search/repositories Qualifiers - pushed_at:" do
	let(:default_results_per_page) { 30 }
	let(:date) { '2022-01-01' }
	let(:date2) { '2022-01-08' }
	let(:date_time) { DateTime.parse(date) }
	let(:date_time2) { DateTime.parse(date2) }
	let(:query) { 'Q' }
	let(:url) { "https://api.github.com/search/repositories?q=#{query}" }
	let(:url_qualifier_pushed_after) { "#{url} pushed:>#{date}" }
	let(:url_qualifier_pushed_before) { "#{url} pushed:<#{date}" }
	let(:url_qualifier_pushed_on) { "#{url} pushed:#{date}" }
	let(:url_qualifier_pushed_range) { "#{url} pushed:#{date}..#{date2}" }

	context "pushed qualifier is greater than a particular date" do
		it 'returns 200 Success with a list of repositories pushed after the date' do
			request = request_API_HTTParty(url_qualifier_pushed_after)
			expect(request.response.code).to eq('200')

			# Filter results by pushed_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'pushed_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
		end
	end

	context "pushed qualifier is less than a particular date" do
		it 'returns 200 Success with a list of repositories pushed before the date' do
			request = request_API_HTTParty(url_qualifier_pushed_before)
			expect(request.response.code).to eq('200')

			# Filter results by pushed_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'pushed_at')

			expect(DateTime.parse(timestamps.max)).to be < date_time
		end
	end

	context "pushed qualifier is on a particular date" do
		it 'returns 200 Success with a list of repositories pushed on the date' do
			request = request_API_HTTParty(url_qualifier_pushed_on)
			expect(request.response.code).to eq('200')

			# Filter results by pushed_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'pushed_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
			expect(DateTime.parse(timestamps.max)).to be < ( date_time + 1 )
		end
	end

	context "pushed qualifier is in a particular range" do
		it 'returns 200 Success with a list of repositories pushed within the range' do
			request = request_API_HTTParty(url_qualifier_pushed_range)
			expect(request.response.code).to eq('200')

			# Filter results by pushed_at
			items = JSON.parse(request.response.body)['items']
			timestamps = filter_hash_keys(items, 'pushed_at')

			expect(DateTime.parse(timestamps.min)).to be > date_time
			expect(DateTime.parse(timestamps.max)).to be < ( date_time2 + 1 )
		end
	end
end