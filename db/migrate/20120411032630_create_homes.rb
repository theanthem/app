class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :home_title, :null => false
      t.string :home_image, :null => false
      t.text :content, :null => false
      t.integer :position, :limit => 3, :default => 0, :null => false
      t.boolean :visibility, :default => false, :null => false

      t.timestamps
    end
  end
end
