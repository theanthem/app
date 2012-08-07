class AddAttachmentPageThumbnailPageDisplayPageBackgroundToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_thumbnail_file_name, :string
    add_column :pages, :page_thumbnail_content_type, :string
    add_column :pages, :page_thumbnail_file_size, :integer
    add_column :pages, :page_thumbnail_updated_at, :datetime
    add_column :pages, :page_display_file_name, :string
    add_column :pages, :page_display_content_type, :string
    add_column :pages, :page_display_file_size, :integer
    add_column :pages, :page_display_updated_at, :datetime
    add_column :pages, :page_background_file_name, :string
    add_column :pages, :page_background_content_type, :string
    add_column :pages, :page_background_file_size, :integer
    add_column :pages, :page_background_updated_at, :datetime
  end

  def self.down
    remove_column :pages, :page_thumbnail_file_name
    remove_column :pages, :page_thumbnail_content_type
    remove_column :pages, :page_thumbnail_file_size
    remove_column :pages, :page_thumbnail_updated_at
    remove_column :pages, :page_display_file_name
    remove_column :pages, :page_display_content_type
    remove_column :pages, :page_display_file_size
    remove_column :pages, :page_display_updated_at
    remove_column :pages, :page_background_file_name
    remove_column :pages, :page_background_content_type
    remove_column :pages, :page_background_file_size
    remove_column :pages, :page_background_updated_at
  end
end
