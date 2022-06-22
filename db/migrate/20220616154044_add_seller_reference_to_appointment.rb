class AddSellerReferenceToAppointment < ActiveRecord::Migration[7.0]
  def change
    change_table :appointments do |t|
      t.references :seller, null: false, foreign_key: true
    end
  end
end
