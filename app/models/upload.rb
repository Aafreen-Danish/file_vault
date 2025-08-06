class Upload < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  before_create :generate_short_url

  private

  def generate_short_url
    self.short_url = SecureRandom.hex(6)
  end
end
