class RemovePaymentUrlFromPaymentPage < ActiveRecord::Migration[7.0]
  def change
    remove_column :payment_pages, :payment_url, :string
  end
end
