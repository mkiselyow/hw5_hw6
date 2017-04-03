class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :name
    remove_column :users, :surname
    remove_column :users, :active
  end

  def down
    add_column :users, :active, :boolean
    add_column :users, :surname, :string
    add_column :users, :name, :string
  end
end
