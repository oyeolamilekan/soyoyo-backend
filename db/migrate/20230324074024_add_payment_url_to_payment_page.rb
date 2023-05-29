class AddPaymentUrlToPaymentPage < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_pages, :payment_url, :string
  end
end
