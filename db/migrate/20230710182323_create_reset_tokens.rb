class CreateResetTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :reset_tokens do |t|
      t.text :link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
