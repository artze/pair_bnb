class ChangeStatusColumnInReservations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reservations, :status, :string
  	add_column :reservations, :status, :integer, default: 0
  end
end
