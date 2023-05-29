class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :private_key
      t.text :public_key
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
