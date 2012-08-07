class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :series
      t.string :title, :null => false
      t.references :speaker
      t.string :scripture, :null => false
      t.string :permalink, :null => false
      t.text :description, :null => false
      # acts as taggable on
      t.date :air_date
      t.string :mp3
      t.string :vodcast
      t.string :hd_video
      t.string :vimeo
      t.integer :duration
      t.integer :viewed
      # :recommended_teachings in recommended teachings
      t.boolean :featured_message, :default => false
      t.string :status, :limit => 20, :default => "Draft", :null => false

      t.timestamps
    end
    add_index("messages", "series_id")
    add_index("messages", "speaker_id")
    
  end
end
