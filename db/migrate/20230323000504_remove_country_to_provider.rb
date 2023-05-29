class RemoveCountryToProvider < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :country, :string
  end
end
