class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.datetime :date
      t.integer :required_age
      t.string :name
      t.string :desc
      t.decimal :price
      t.integer :free_seats
      t.attachment :poster

      t.timestamps
    end
  end
end
