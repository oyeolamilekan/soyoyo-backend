class ResetToken < ApplicationRecord
  belongs_to :user
  before_create :generate_reset_token
  before_update :generate_reset_token

  private
  def generate_reset_token
    self.link = GenerateRandomString.call(20)
  end
end
