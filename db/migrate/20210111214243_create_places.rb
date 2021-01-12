class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :continent, null: false
      t.string :country, null: false
      t.string :city
      t.string :admin_area
      t.string :neighborhood
      t.float :gps_coordinate
      t.timestamps
    end
  end
end
