class AddDataToMaps < ActiveRecord::Migration[5.0]
  def change
  	create_table :infomaps do |t|
  		t.string :name_station
  		t.string :name_location
      t.integer :waterlevel
      t.integer :rain
      t.integer :water_sealevel
      t.integer :tropical_level
      t.integer :bank_level
      t.string :river_name
      t.string :place
		  t.st_point :lonlat, geographic: true
      t.integer :time
  		t.timestamps null: false
  	end
  end
end
