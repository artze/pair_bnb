class AddStatusToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :status, :string
  end
end