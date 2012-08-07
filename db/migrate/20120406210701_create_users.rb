class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :limit => 25, :null => false
      t.string :last_name, :limit => 40, :null => false
      t.string :username, :limit => 25, :null => false
      t.string :hashed_password, :limit => 40
      t.string :salt, :limit => 40
      t.string :email, :limit => 50, :null => false
      t.string :title, :limit => 100
      t.text :bio, :null => false
      t.integer :access_level, :limit => 2, :default => 0, :null => false 
      t.string :twitter, :limit => 50
      
      t.timestamps
    end
    add_index('users', 'username')
    
    create_table :messages_users do |t|
        t.integer "user_id"
        t.integer "message_id"  
      end
    add_index :messages_users, ["user_id", "message_id"]
    User.create(:first_name => 'Devan', :last_name => 'Flaherty', :username => 'devanflaherty', :password => 'skywalker', :email => 'devanflaherty@me.com', :title => 'Creative Director', :bio => 'Just another creative guy, trying to change the world.', :access_level => 9, :twitter => 'devanflaherty')
  end
end
