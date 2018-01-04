class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.boolean :admin
      t.date :birthday

      t.timestamps
    end
  end
end
