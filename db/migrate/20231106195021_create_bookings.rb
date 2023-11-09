class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.datetime :booking_datetime

      t.timestamps
    end
  end
end
