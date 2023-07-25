require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Associations' do
    it { should have_many :items }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'Instance Methods' do
    
  end
end