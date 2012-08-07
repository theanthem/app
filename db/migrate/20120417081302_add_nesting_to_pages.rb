class AddNestingToPages < ActiveRecord::Migration
  def change
    add_column :pages, :lft, :integer 
    add_column :pages, :rgt, :integer 
    add_column :pages, :depth, :integer # this is optional.
  end
end
