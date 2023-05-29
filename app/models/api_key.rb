class ApiKey < ApplicationRecord
  belongs_to :business

  before_create :generate_api_keys
  validates_presence_of :business_id

  def as_json(options = {})
    super(options.merge({ except: [:id, :business_id] }))
  end

  def self.regenerate_api_keys(business_slug)
    api_key_obj = ApiKey.joins(:business).find_by(businesses: { slug: business_slug })
    api_key_obj.update(public_key: "pk_live_#{Utils.generate_random_string}", private_key: "pr_live_#{Utils.generate_random_string}")
  end

  def generate_api_keys
    self.public_key = "pk_live_#{Utils.generate_random_string}"
    self.private_key = "pr_live_#{Utils.generate_random_string}"
  end

end
