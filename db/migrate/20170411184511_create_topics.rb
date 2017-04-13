class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :create_table
      t.string :topic_name

      t.timestamps
    end
  end
end
