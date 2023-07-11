class AddSlugToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :slug, :string
  end
end
