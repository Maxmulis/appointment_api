class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.datetime :time
      t.string :name
      t.string :phone
      t.references :realtor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
