class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.date :booking_start
      t.date :booking_end
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true

      t.timestamps
    end
  end
end
