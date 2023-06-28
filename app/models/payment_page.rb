class PaymentPage < ApplicationRecord
  enum :status, [:enabled, :disabled]
  enum :currency, [:naira, :dollar], default: :naira
  belongs_to :business
  before_update :slugify_url
  before_create :slugify_url
  validates_uniqueness_of :title, message: "A Payment page with this name already exits."
  validates_presence_of :amount
  scope :enabled, -> { where(status: :enabled) }
  scope :disabled, -> { where(status: :disabled) }

  def as_json(options = {})
    super(options.merge({ except: [:id, :business_id], methods: [:payment_url] }))
  end

  def payment_url
    "#{ENV['BASE_URL']}app/collect_payment/#{self.slug}"
  end

  private
  def slugify_url
    self.slug = slugify(self.title)
  end

  def slugify(string)
    slug = string.gsub(/[^a-zA-Z0-9]/, '-').downcase
    slug.gsub!(/^-+|-+$/, '')
  
    return slug
  end

  def slugify_title
    self.slug = slugify(title)
  end
end
