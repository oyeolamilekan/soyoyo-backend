class Provider < ApplicationRecord
  belongs_to :business
  validates_presence_of :name, :title, :business_id, :public_key
  validate :unique_provider_for_merchants, on: :create

  def as_json(options = {})
    super(options.merge({ except: [:business_id, :user_id] }))
  end

  def unique_provider_for_merchants
    if Provider.exists?(title: title, business_id: business_id)
      errors.add(:base, "#{title} Already exists with your business")  
    end
  end
end
