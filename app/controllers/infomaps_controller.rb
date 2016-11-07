class InfomapsController < ApplicationController
	def index
		#@infomap = Infomap.find(1)
	end

	def test
		stg01 = Infomap.find(1).lonlat
		stg02 = Infomap.find(2).lonlat
		tg01 = Infomap.find(5).lonlat
		@result = Infomap.find_by_sql("SELECT ST_Distance(
		  ST_GeometryFromText('#{stg01}'),
		  ST_GeometryFromText('#{stg02}'))")
		@data = "#{stg01},#{stg02}"

		dwithin = Infomap.find_by_sql("SELECT name_station
			FROM infomaps
			WHERE ST_DWithin(
	        ST_GeomFromText('#{stg01}'),
	        ST_GeomFromText('#{stg02}'),
	        1
	      )")
		@all_dwithin = dwithin
		dwithin.each do |d|
			@dwithin = d.name_station
		end

		within = Infomap.find_by_sql("SELECT name_station
			FROM infomaps
			WHERE ST_Within(
			ST_GeomFromText('#{tg01}'),
			ST_GeomFromText('POLYGON((99.5388794 20.0997856,
			99.6844482 19.7511943,
			100.1925659 19.5908442,
			100.5825806 19.9733488,
			100.3573608 20.3832508,
			99.7393799 20.3678024,
			99.4894409 20.2828087,
			99.5388794 20.0997856))')
			)")
		@all_within = within
		within.each do |w|
			@within = w.name_station
		end
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
