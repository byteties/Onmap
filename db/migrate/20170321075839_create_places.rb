class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :type
      t.st_point :lonlat, geographic: true
      t.integer :infomap_id	
      t.timestamps
    end
  end
end
