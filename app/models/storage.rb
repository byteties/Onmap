class Storage < ApplicationRecord
	belongs_to :infomap

	def self.getjson_url(name,id)
		# loop do
		# get JSON
		result = Net::HTTP.get(URI.parse('http://www.crflood.com/data-service/data-level-now.php?s='+name))
		# parse JSON
		json = JSON.parse(result)
		
		#check rain ,check water flood		
		drain = json['rain']
		dtemperature = json['temperature']
		dwaterlevel = json['water_sealevel']
		dcriticallevel = json['critical_level']

		if(drain[0] != 0)
			numrain = 1
		else
			numrain = 0
		end
		if(dwaterlevel[0] >= dcriticallevel[0])
			numflood = 1
		else
			numflood = 0
		end		
		
		# save data to DB
		Storage.create(infomap_id: id,
		 		name_station: json['name'],
		 		rain: json['rain'][0],
		 		temperatare: json['temperature'][0],
		 		water_level: json['water_sealevel'][0],
		 		critical_level: json['critical_level'][0],
		 		checkrain: numrain,
		 		checkflood: numflood,
      			time: json['stime']
		)
		# sleep(5.minutes)
	end
end