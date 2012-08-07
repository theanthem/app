class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.references :user
      t.string :title, :null => false
      t.string :subtitle
      t.string :media_type, :default => "Video", :null => false
      t.string :description, :null => false
      t.text :content
      t.boolean :featured_media
      t.string :permalink, :null => false
      t.string :link1_title, :limit => 140
      t.string :link1, :limit => 140
      t.string :status, :limit => 20, :default => "Draft", :null => false
      t.date :published_at

      t.timestamps
    end
    add_index("media", "permalink")
    
    create_table :users_media do |t|
      t.references :user
      t.references :media  
    end
    add_index :users_media, ["user_id", "media_id"]
  end
end
