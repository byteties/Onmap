class AddDataToMaps < ActiveRecord::Migration[5.0]
  def change
  	create_table :infomaps do |t|
  	  t.string :name_station
  	  t.string :name_location
      t.string :river
      t.string :sub_district
      t.string :district
      t.st_point :lonlat, geographic: true
      t.st_polygon :area, geographic: true
  	  t.timestamps null: false
  	end
  end
end
