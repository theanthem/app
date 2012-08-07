class AddAttachmentSectionDisplaySectionBackgroundToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :section_display_file_name, :string
    add_column :sections, :section_display_content_type, :string
    add_column :sections, :section_display_file_size, :integer
    add_column :sections, :section_display_updated_at, :datetime
    add_column :sections, :section_background_file_name, :string
    add_column :sections, :section_background_content_type, :string
    add_column :sections, :section_background_file_size, :integer
    add_column :sections, :section_background_updated_at, :datetime
  end

  def self.down
    remove_column :sections, :section_display_file_name
    remove_column :sections, :section_display_content_type
    remove_column :sections, :section_display_file_size
    remove_column :sections, :section_display_updated_at
    remove_column :sections, :section_background_file_name
    remove_column :sections, :section_background_content_type
    remove_column :sections, :section_background_file_size
    remove_column :sections, :section_background_updated_at
  end
end
