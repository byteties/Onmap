class Storage < ApplicationRecord
	belongs_to :infomap

	# get JSON
	result = Net::HTTP.get(URI.parse('http://www.crflood.com/data-service/data-level-now.php?s=stg01'))

	# parse JSON
	json = JSON.parse(result)

	# save data to DB
	# json['results']['collection1'][1..-1].each do |data| # [1..-1] ignores first dummy element
 #  	Stock.create(
 #    	company: data['property1']['text'],
 #    	url: data['url'],
 #    	pe: data['property2'].gsub(',', ''), # .gsub removes thousands separator
 #    	quote: data['property3'].gsub(',', '')
 #  	)
end
end
