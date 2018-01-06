class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :date
      t.string :datetime,
      t.string :required_age
      t.string :integer,
      t.string :name
      t.string :string,
      t.string :desc
      t.string :string,
      t.string :price
      t.string :decimal,
      t.string :free_seats
      t.string :integer

      t.timestamps
    end
  end
end
