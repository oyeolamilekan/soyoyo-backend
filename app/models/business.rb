class Business < ApplicationRecord
  belongs_to :user
  has_one :api_key
  has_many :payment_page

  validates_presence_of :user_id, :title
  validates_uniqueness_of :title, message: "Business title already exists"

  before_create :slugify_slug
  before_update :slugify_slug
  after_create :create_api_keys

  def as_json(options = {})
    super(options.merge({ except: [ :user_id ] }))
  end

  private
  def slugify(string)
    slug = string.gsub(/[^a-zA-Z0-9]/, '-').downcase
  
    slug.gsub!(/^-+|-+$/, '')
  
    return slug
  end

  def slugify_slug
    self.slug = slugify(title)
  end

  def create_api_keys
    CreateApiKeysService.call(self.id)
  end
end
