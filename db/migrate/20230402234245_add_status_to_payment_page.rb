class AddStatusToPaymentPage < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_pages, :status, :integer, default: 0
  end
end
