require 'rails_helper'

RSpec.describe Sell, type: :model do
  let(:sell_one) { build(:sell, :with_attributes, :with_article) }
  let(:sell_two) { build(:sell, :with_attributes, :with_article, :with_more_quantity) }
  let(:sell_three) { build(:sell, :with_attributes, article: article_one) }
  let(:article_one) { build(:article, :with_attributes, :with_stock) }
  let(:invalid_sell) { build(:sell, :with_attributes) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(sell_one).to be_valid
    end

    it 'should be an invalid instance' do
      expect(invalid_sell).to be_invalid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:date_of_sell) }
    it { should validate_presence_of(:article) }
  end

  describe 'custom validations' do
    it 'should validate the quantity against the article.in_stock attribute' do
      expect(sell_two).to_not be_valid
      expect(sell_two.errors).to be_present
      expect(sell_two.errors.first.message).to be_eql('es mayor a los articulos en stock')
    end
  end

  describe 'callbacks' do
    it 'should decrease the article.in_stock value depending on the quantity of sells' do
      article_one.save
      expect(article_one.in_stock).to be_eql(15)
      sell_three.save
      expect(article_one.in_stock).to be_eql(12)
    end
  end
end
