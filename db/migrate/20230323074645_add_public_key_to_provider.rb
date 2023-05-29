class AddPublicKeyToProvider < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :public_key, :string
  end
end
