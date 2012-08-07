class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :page
      t.string :title, :limit => 100, :null => false
      t.string :content_type, :limit => 20, :default => "Text", :null => false
      t.text :content, :null => false
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

      t.timestamps
    end
    add_index('sections', 'page_id')
    
    create_table :section_edits do |t|
      t.references :user
      t.references :section
      t.string :summary
      t.timestamps
    end
    add_index :section_edits, ['user_id', 'section_id']
    
  end
end
