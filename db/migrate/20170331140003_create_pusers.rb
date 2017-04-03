class CreatePusers < ActiveRecord::Migration
  def change
    create_table :pusers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
