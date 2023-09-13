require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category_one) { build(:category, :with_attributes) }
  let(:article_one) { build(:article, :with_attributes, :with_stock) }
  let(:invalid_category) { build(:category) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(category_one).to be_valid
    end

    it 'should be an invalid instance' do
      expect(invalid_category).to be_invalid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:articles) }
  end

  describe 'set articles' do
    it 'should associate articles' do
      category_one.save
      article_one.save

      expect(category_one.articles.count).to be_eql(0)

      category_one.articles << article_one

      expect(category_one.articles.count).to be_eql(1)
    end
  end
end
