pclass RemoveColomnsFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :name
  end

  def down
    add_column :books, :name, :string
  end
end
