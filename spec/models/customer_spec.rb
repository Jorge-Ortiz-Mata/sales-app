require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:default_customer) { build(:customer, :with_attributes) }
  let(:customer_one) { build(:customer, :with_attributes, full_name: 'Ana Perez') }
  let(:invalid_customer) { build(:customer) }

  describe 'instances' do
    it 'should be valid' do
      expect(default_customer).to be_valid
    end

    it 'should not be valid' do
      expect(invalid_customer).to be_invalid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address) }
    it 'should have the phoner number with a maximum length of 10' do
      default_customer.phone_number = 123_456_789_012

      expect(default_customer).to_not be_valid
    end

    it 'should reject the phone number if it contains letters' do
      default_customer.phone_number = '12345jorge'

      expect(default_customer).to_not be_valid
    end
  end

  describe 'scopes' do
    it 'should return customers with a certain name' do
      default_customer.save
      customer_one.save

      expect(Customer.all.count).to be_eql(2)
      expect(Customer.filter_by_name('An').count).to be_eql(1)
    end
  end
end
