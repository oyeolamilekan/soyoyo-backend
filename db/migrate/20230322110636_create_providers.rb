class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :title
      t.text :name
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
