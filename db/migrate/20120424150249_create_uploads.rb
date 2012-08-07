class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer 'post_id'
      t.string 'description'
      t.timestamps
    end
  end
end
