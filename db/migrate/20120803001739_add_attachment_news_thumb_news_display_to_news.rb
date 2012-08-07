class AddAttachmentNewsThumbNewsDisplayToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :news_thumb_file_name, :string
    add_column :news, :news_thumb_content_type, :string
    add_column :news, :news_thumb_file_size, :integer
    add_column :news, :news_thumb_updated_at, :datetime
    add_column :news, :news_display_file_name, :string
    add_column :news, :news_display_content_type, :string
    add_column :news, :news_display_file_size, :integer
    add_column :news, :news_display_updated_at, :datetime
  end

  def self.down
    remove_column :news, :news_thumb_file_name
    remove_column :news, :news_thumb_content_type
    remove_column :news, :news_thumb_file_size
    remove_column :news, :news_thumb_updated_at
    remove_column :news, :news_display_file_name
    remove_column :news, :news_display_content_type
    remove_column :news, :news_display_file_size
    remove_column :news, :news_display_updated_at
  end
end
