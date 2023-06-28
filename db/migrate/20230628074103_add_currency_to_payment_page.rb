class AddCurrencyToPaymentPage < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_pages, :currency, :integer, default: 0
  end
end
