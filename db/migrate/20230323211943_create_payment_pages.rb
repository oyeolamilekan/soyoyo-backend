class CreatePaymentPages < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_pages do |t|
      t.string :title
      t.string :slug
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
