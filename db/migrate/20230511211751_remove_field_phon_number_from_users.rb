class RemoveFieldPhonNumberFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone_number, :string
  end
end
