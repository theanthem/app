class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title, :null => false
      t.string :subtitle
      t.string :book
      t.string :permalink, :null => false
      t.text :description
      t.date :start_date, :null => false
      t.date :end_date
      t.boolean :featured_series, :default => false, :null => false
      t.boolean :visibility, :default => false, :null => false
      t.integer :messages_count, :limit => 2, :default => 0, :null => false

      t.timestamps
    end
    
    Series.find(:all).each do |series|
      current_count = series.messages.length
      series.update_attribute(:messages_count, current_count)
    end
    Series.create(:title => "First Series", :subtitle => "A study through...", 
    :book => "Mark", :permalink => "first_series", :description => "This is a series about...", :start_date => "12/04/1989",
    :featured_series => true, :visibility => false)
  end
end
