class CreateRealtors < ActiveRecord::Migration[7.0]
  def change
    create_table :realtors do |t|
      t.string :name
      t.string :city
      t.float :latitude
      t.float :longitude

      t.timestamps

      t.index %i[latitude longitude]
    end
  end
end
