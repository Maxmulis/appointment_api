class ChangeColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :latitude, :lat
    rename_column :appointments, :longitude, :lng
  end
end
