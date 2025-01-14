class AddRemainingTicketsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :remaining_tickets, :integer
  end
end
