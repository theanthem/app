class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title, :null => false
      t.string :subtitle
      t.string :permalink, :null => false
      t.string :news_thumb
      t.string :description, :null => false
      t.boolean :featured_news, :default => false 
      t.text :content
      t.boolean :event, :default => false 
      t.date :event_date
      t.string :contact
      t.string :contact_email
      t.string :link1_title, :limit => 140
      t.string :link1, :limit => 140
      t.string :link2_title, :limit => 140
      t.string :link2, :limit => 140
      t.string :link3_title, :limit => 140
      t.string :link3, :limit => 140
      t.string :link4_title, :limit => 140
      t.string :link4, :limit => 140
      t.integer :position, :limit => 2, :default => 0, :null => false
      t.string :status, :limit => 20, :default => "Draft", :null => false
      t.date :birth_date
      t.date :expire_date

      t.timestamps
    end
    add_index("news", "permalink")
    
    create_table :users_news do |t|
      t.references :user
      t.references :news  
    end
    add_index :users_news, ["user_id", "news_id"]
    
  end
end
