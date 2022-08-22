class AddUserToMovements < ActiveRecord::Migration[7.0]
  def change
    add_reference :movements, :user, null: true, foreign_key: true
  end
end
