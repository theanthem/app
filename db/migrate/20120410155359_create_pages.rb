class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :parent_id
      t.string :name, :null => false
      t.string :permalink, :null => false
      t.string :template, :default => "basic"
      t.integer :position, :limit => 2, :default => 0, :null => false
      t.string :visibility, :default => "Visible"
      t.date :published_at
      t.string :status, :limit => 20, :default => "Draft", :null => false

      t.timestamps
    end
    add_index("pages", "parent_id")
    add_index("pages", "permalink")
    
  end
end
