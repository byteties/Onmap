class CreateStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :storages do |t|
      t.integer :infomap_id
  	  t.string  :name_station
      t.integer :rain
      t.integer :temperatare
      t.integer :water_level
      t.integer :warning_level
      t.integer :critical_level
      t.string  :time
      t.timestamps
    end
  end
end
