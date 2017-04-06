class Changetype < ActiveRecord::Migration[5.0]
  def change
  	change_column :storages, :temperatare, :float, precision: 5, scale: 2
  	change_column :storages, :water_level, :float, precision: 5, scale: 2
  	change_column :storages, :warning_level, :float, precision: 5, scale: 2
  	change_column :storages, :critical_level, :float, precision: 5, scale: 2
  end
end
