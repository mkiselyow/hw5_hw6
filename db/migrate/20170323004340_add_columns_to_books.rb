class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :name, :string
    add_column :books, :description, :string
    add_column :books, :price, :string
    add_column :books, :year, :string
  end
end
