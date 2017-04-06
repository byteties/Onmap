class AddPlaces < ActiveRecord::Migration[5.0]
  def change
  	create_table :places do |t|
  	  t.string :place_name
      t.string :place_type
      t.st_point :place_lonlat, geographic: true
      t.integer :place_infomap_id
      t.timestamps
  	end
  end
end
