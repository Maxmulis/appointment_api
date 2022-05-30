class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :address, null: false
      t.datetime :time, null: false
      t.string :name, null: false
      t.string :phone, null: false
      t.references :realtor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
