require 'rails_helper'

RSpec.describe Injection, type: :model do
  describe 'associations' do
    it { should belong_to(:patient) }
  end
end
