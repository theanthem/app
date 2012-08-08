class AddSubpositionToPages < ActiveRecord::Migration
  def self.up
     add_column :pages, :subposition, :integer, :limit => 2, :default => 0, :null => false
  end
  
  def self.down
     remove_column :pages, :subposition
  end
end
