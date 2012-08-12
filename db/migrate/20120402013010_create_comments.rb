class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post
      t.string :author, :limit => 25, :null => false
      t.string :author_email, :limit => 50, :null => false
      t.text :content, :null => false
      t.string :status, :limit => 25, :default => "New", :null => false

      t.timestamps
    end
    add_index("comments", "post_id")
    
  end
end
