class InfomapsController < ApplicationController
	def index
		
	end

	def point		
		lng = params[:lng][0..8]
		lat = params[:lat][0..8]
		type = params[:type]
		startDate = params[:startDate]
		finalDate = params[:finalDate]
			point = 'POINT('+lng+' '+lat+')'
			count = Infomap.count
			for i in 1..count
				data = Infomap.find(i)
				if(data.area != nil)
					checkinpolygon = Infomap.find_by_sql("SELECT name_station FROM infomaps WHERE ST_Within(ST_GeomFromText('#{point}'),ST_GeomFromText('#{data.area}'))")
					if(checkinpolygon != [])
						respond_to do |format|
							if(startDate != nil || finalDate != nil)
		    					maxlevel = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}").maximum(:water_level)
		    					minlevel = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}").minimum(:water_level)
								avglevel = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}").average(:water_level).to_f
								sumflood = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}").sum(:checkflood)				
								sumrain = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}").sum(:checkrain)	
								fullData = Storage.where("time BETWEEN '#{startDate}' AND '#{finalDate}' AND infomap_id=#{data.id}")							
							end		
							flooddata = Storage.where(infomap_id: data.id).last
	    					format.json { render json: {"lat"=> lat,"lng"=>lng ,"flooddata" =>flooddata ,"maxlevel"=>maxlevel,"minlevel"=>minlevel,"avglevel"=>avglevel,"sumflood"=>sumflood,"sumrain"=>sumrain,"fullData" => fullData}}
	  					end
	  					break
					end
				end	
			end
	end			
	
	def circle
		lng = params[:lng][0..8]
		lat = params[:lat][0..8]
		radius = params[:radius]
		point = 'POINT('+lng+' '+lat+')'
		count = Infomap.count
		x.each do |data|
			@checkincircle = Infomap.find_by_sql("SELECT name_station FROM infomaps
			WHERE ST_Within(
				ST_GeometryFromText('#{data.lonlat}'),
				ST_GeometryFromText('#{locat}'),
				5)")			
		end
		respond_to infomaps_index
	end 	

 	def testjson
 	# 	result = Net::HTTP.get(URI.parse('http://www.crflood.com/data-service/data-level-now.php?s=stg03'))
		# # parse JSON
		# json = JSON.parse(result)

		# drain = json['rain']
		# dwaterlevel = json['water_sealevel'].map(&:to_i)
		# dcriticallevel = json['critical_level'].map(&:to_i)

		# if(drain != 0)
		# 	numrain = 1
		# else
		# 	numrain = 0
		# end
		# if(dwaterlevel[0] >= dcriticallevel[0])
		# 	numflood = 1
		# else
		# 	numflood = 0
		# end
		
		# respond_to do |format|
  #   		format.json { render json: {"rain"=> drain,"water_level"=>json['water_sealevel'][0] ,"critical_level" =>dcriticallevel,"numrain"=>numrain,"numflood"=>numflood}}
  # 		end				
 	end

 	
	def test
		
		# stg01 = Infomap.find(1).lonlat
		# stg02 = Infomap.find(2).lonlat
		# tg01 = Infomap.find(5).lonlat
		# @result = Infomap.find_by_sql("SELECT ST_Distance(
		#   ST_GeometryFromText('#{stg01}'),
		#   ST_GeometryFromText('#{stg02}'))")
		# @data = "#{stg01},#{stg02}"

		# dwithin = Infomap.find_by_sql("SELECT name_station
		# 	FROM infomaps
		# 	WHERE ST_DWithin(
	 #        ST_GeomFromText('#{stg01}'),
	 #        ST_GeomFromText('#{stg02}'),
	 #        1
	 #      )")
		# @all_dwithin = dwithin
		# dwithin.each do |d|
		# 	@dwithin = d.name_station
		# end

		# testdwithin = Infomap.where("ST_DWithin(
	 #        ST_GeomFromText('#{stg01}'),
	 #        ST_GeomFromText('#{stg02}'),
	 #        1
	 #      )")
		# @testall_dwithin = testdwithin

		# within = Infomap.find_by_sql("SELECT name_station
		# 	FROM infomaps
		# 	WHERE ST_Within(
		# 	ST_GeomFromText('#{tg01}'),
		# 	ST_GeomFromText('POLYGON((99.5388794 20.0997856,
		# 	99.6844482 19.7511943,
		# 	100.1925659 19.5908442,
		# 	100.5825806 19.9733488,
		# 	100.3573608 20.3832508,
		# 	99.7393799 20.3678024,
		# 	99.4894409 20.2828087,
		# 	99.5388794 20.0997856))')
		# 	)")
		# @all_within = within
		# within.each do |w|
		# 	@within = w.name_station
		# end

		# @testwithin = Infomap.find_by_sql("SELECT name_station
		# 	FROM infomaps
		# 	WHERE ST_Within(
		# 	ST_GeomFromText('POINT(99.71274 20.79207)'),
		# 	ST_GeomFromText('POLYGON((99.679663 19.188582,100.558569 19.923608,99.827441 20.566058,98.841418 19.790085,99.679663 19.188582))'))")

		# @test = Infomap.where("ST_DWithin(
	 #        ST_GeomFromText('#{stg01}'),
	 #        ST_GeomFromText('point (100.47661 20.62297)'),
	 #        1
	 #      )")
		
		# @target = Infomap.last
		# @degree_radius = 0.2249
		# @valid_points = Infomap.where("ST_DWithin(lonlat, ST_PointFromText('#{@target.lonlat}',  #{@degree_radius}))")

		#POINT(99.71274 20.79207)
		#'POLYGON((99.679663 19.188582,100.558569 19.923608,99.827441 20.566058,98.841418 19.790085,99.679663 19.188582))'		
		# @result = Infomap.where("ST_DWithin(lonlat,ST_GeomFromText('POINT(20 100)',26918),1000)")
		# polygons = ActiveRecord::Base.connection.execute("SELECT ST_Area(shape2) FROM infomaps")
		# polygons.each do |record|
  		# 				@polygon = record
		# end	

		# x2 = "SELECT ST_Buffer(ST_GeomFromText('LINESTRING (50.0 50.0, 150.0 150.0, 150.0 50.0)'), 10, 'endcap=round join=round');"
		# stg = ActiveRecord::Base.connection.execute(x2)
		# @result = Infomap.select('GeometryType(stg)')
		# @stg = stg.getvalue(0,0)
		# stg.each do |x|
		# 	@stg = x
		# end
 
		# x3 = "SELECT GeometryType()"
		# @stg = result.methods - Object.methods
		
		# a = Infomap.find(2)
		# b = Infomap.find(3)
		# distance = ActiveRecord::Base.connection.execute("SELECT ST_Distance(#{a.shape1},#{b.shape1})")
		# a = Infomap.find(5)
		# b = Infomap.find(4)
		# @geo = ActiveRecord::Base.connection.execute("ST_Covers(#{a.lonlat},#{b.shape2});")

		# @target = Infomap.first
		# @degree_radius = 0.2249
		# valid_points = Infomap.where("ST_DWithin(lonlat, ST_PointFromText('#{@target.lonlat}',  #{@degree_radius}))")
		# if(valid_points == true)
		# 	@valid_points = "true"
		# elsif(valid_points == false)
		# 	@valid_points = "false"
		# else 
		# 	@valid_points = valid_points
		# end		
			
		# within = ActiveRecord::Base.connection.execute("ST_ClusterWithin(, 2000)")


		# valid_points.each do |x|
		# 	@valid_points = x
		# end

		# within = Infomap.select("ST_DWithin(shape1,lonlat, 3000);")
		# within.each do |x|
		# 	@within = x
		# end

		# geo = Infomap.select("*, ST_AsGeoJSON(ST_simplify(geom,500)) as my_geo")
		#   	geo.each do |result|
		#   		@geo = result
		#   	end
	 end
end
