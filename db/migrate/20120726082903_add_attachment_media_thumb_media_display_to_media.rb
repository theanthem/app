class AddAttachmentMediaThumbMediaDisplayToMedia < ActiveRecord::Migration
  def self.up
    add_column :media, :media_thumb_file_name, :string
    add_column :media, :media_thumb_content_type, :string
    add_column :media, :media_thumb_file_size, :integer
    add_column :media, :media_thumb_updated_at, :datetime
    add_column :media, :media_display_file_name, :string
    add_column :media, :media_display_content_type, :string
    add_column :media, :media_display_file_size, :integer
    add_column :media, :media_display_updated_at, :datetime
  end

  def self.down
    remove_column :media, :media_thumb_file_name
    remove_column :media, :media_thumb_content_type
    remove_column :media, :media_thumb_file_size
    remove_column :media, :media_thumb_updated_at
    remove_column :media, :media_display_file_name
    remove_column :media, :media_display_content_type
    remove_column :media, :media_display_file_size
    remove_column :media, :media_display_updated_at
  end
end
