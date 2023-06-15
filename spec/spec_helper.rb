require 'httparty'
require 'net/http'
require 'openssl'
require 'json'

# Authenticated Users get a larger rate limit
PAT = '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'

def request_API_HTTParty(url = 'https://api.github.com/search/repositories?q=Github')
	url.sub!('https://', "https://#{PAT}@")
	result = HTTParty.get(url)
	
	# Retry once when the rate limit has been reached
	return result unless result.response.code == '403'

	puts "\n\nRate Limit Reached at #{Time.now}, Waiting to Retry...\n\n"
	sleep(60)
	HTTParty.get(url)
end

def download_JSON(url)
	HTTParty.get(url).parsed_response
end

# TODO - Repos can be in the results if the README.md doesn't exist also
def download_README(owner, repo, branch)
	url = "https://raw.githubusercontent.com/#{owner}/#{repo}/#{branch}/README.md"
	HTTParty.get(url)
end

def filter_hash_keys(h, key)
	values = []

	h.each do |item|
		values.push(item[key])
	end
	values
end

def filter_hash_keys2(h, key, key2)
	values = []

	h.each do |item|
		values.push(item[key][key2])
	end
	values
end


def get_topics(h)
	topics = []
	h.each do |item|
		topics.push(item['topics'].join(''))
	end
	topics
end

def get_topics_counts(h)
	topics_counts = []
	h.each do |item|
		topics_counts.push(item['topics'].size)
	end
	topics_counts
end