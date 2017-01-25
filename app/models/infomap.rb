class Infomap < ApplicationRecord
	# def st_buffer		
	# 	ST_Buffer(ST_GeomFromText("POINT (20 100)"),50,'quad_segs=8')
	# end

	# SRID = 4326 #WGS84

	# geometry column is geom
	# pt is a GeoRuby Point
	# def self.find_within_radius(pt, dist = 0.01)
	#   self.all :conditions => "ST_DWithin(geom, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', #{SRID}), #{dist})"
	# end
	
end
