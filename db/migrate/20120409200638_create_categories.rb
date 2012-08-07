class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :limit => 50, :null => false
      t.string :short_name, :limit => 30, :null => false
      t.string :description, :null => 
      t.timestamps
    end
    create_table :categories_posts do |t|
      t.references :category
      t.references :post
    end
    add_index :categories_posts, ["category_id", "post_id"]
  end
  
end
