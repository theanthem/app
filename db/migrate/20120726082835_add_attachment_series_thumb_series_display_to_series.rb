class AddAttachmentSeriesThumbSeriesDisplayToSeries < ActiveRecord::Migration
  def self.up
    add_column :series, :series_thumb_file_name, :string
    add_column :series, :series_thumb_content_type, :string
    add_column :series, :series_thumb_file_size, :integer
    add_column :series, :series_thumb_updated_at, :datetime
    add_column :series, :series_display_file_name, :string
    add_column :series, :series_display_content_type, :string
    add_column :series, :series_display_file_size, :integer
    add_column :series, :series_display_updated_at, :datetime
  end

  def self.down
    remove_column :series, :series_thumb_file_name
    remove_column :series, :series_thumb_content_type
    remove_column :series, :series_thumb_file_size
    remove_column :series, :series_thumb_updated_at
    remove_column :series, :series_display_file_name
    remove_column :series, :series_display_content_type
    remove_column :series, :series_display_file_size
    remove_column :series, :series_display_updated_at
  end
end
