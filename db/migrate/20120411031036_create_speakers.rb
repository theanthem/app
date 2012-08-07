class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :title, :default => "Pastor"
      t.string :church
      t.text :bio
      # remove speaker_image
      t.string :speaker_image
      t.string :website
      t.string :twitter
      t.integer :messages_count, :limit => 4, :default => 0

      t.timestamps
    end
    
    Speaker.find(:all).each do |speaker|
      current_count = speaker.messages.length
      speaker.update_attribute(:messages_count, current_count)
    end
    
  end
end
