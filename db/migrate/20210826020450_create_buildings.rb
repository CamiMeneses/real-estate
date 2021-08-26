class CreateBuildings < ActiveRecord::Migration[6.1]
  def change
    create_table :buildings do |t|
      t.string :name, :limit => 128, :null => false
      t.string :type_cd
      t.string :street, :limit => 128, :null => false
      t.string :external_number, :limit => 12, :null => false
      t.string :internal_number
      t.string :neighborhood , :limit => 128, :null => false
      t.string :city, :limit => 64, :null => false
      t.string :country, :limit => 2, :null => false
      t.integer :rooms, :null => false
      t.integer :bathrooms, :null => false
      t.string :comments, :limit => 128

      t.timestamps
    end
  end
end
