class Patient < ApplicationRecord
  has_many :injections, dependent: :destroy

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.uuid
  end
end
