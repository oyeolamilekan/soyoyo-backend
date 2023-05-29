class AddAmountToPaymentPage < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_pages, :amount, :decimal, default: 0.00
  end
end
