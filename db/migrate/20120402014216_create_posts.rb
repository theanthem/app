class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :limit => 100, :null => false
      t.references :user 
      t.string :permalink, :limit => 100, :null => false
      t.text :content, :null => false
      t.string :featured_image
      t.boolean :featured_post, :default => false
      t.date :published_at
      t.string :status, :limit => 20, :default => "Draft", :null => false
      t.integer :comments_count, :limit => 4, :default => 0
      
      t.timestamps
    end
    add_index("posts", "user_id")
    

    Post.create(:title => 'Hello World!', :permalink => 'your_first_post', :content => "This is your first post.", :status => 'Draft')
    
  end
  
end
