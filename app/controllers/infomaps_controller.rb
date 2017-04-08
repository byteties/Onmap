class InfomapsController < ApplicationController
	def index
		array =[]
		data = []
		count = Infomap.count
		for i in 1..count
			station = Infomap.find(i)
			flood = Storage.where(infomap_id: station.id).last
			# name station,rain,temperatare,water_level,critical_level,checkflood,checkrain
			if(flood.rain == nil)
				rain_state = 'ไม่สามารถอ่านค่าการเกิดฝนได้'
			elsif (flood.rain == 0)
				rain_state = 'ปกติ'
			else
				rain_state = 'กำลังเกิดฝน'
			end

			if(flood.temperatare == nil)
				temperatare_state = 'ไม่สามารถอ่านค่าอุณหภูมิได้'
			else
				temperatare_state = "#{flood.temperatare}"+"°C"
			end

			if(flood.checkflood == 1)
				flood_state = "กำลังเกิดน้ำท่วม"
			else
				flood_state = "ปกติ"
			end
			array = [station.name_station,temperatare_state,flood.water_level,flood.critical_level,rain_state,flood_state]
			data << array
		end
		@data = data
	end

	def point		
		lng = params[:lng][0..8]
		lat = params[:lat][0..8]
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

	def test
	end
end