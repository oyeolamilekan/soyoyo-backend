class AddCountryToProvider < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :country, :string
  end
end
