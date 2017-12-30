class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :address
      t.decimal :price
      t.string :email_address
      t.string :seat_id_seq

      t.timestamps
    end
  end
end
