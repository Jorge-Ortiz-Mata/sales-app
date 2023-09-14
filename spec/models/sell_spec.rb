require 'rails_helper'

RSpec.describe Sell, type: :model do
  let(:sell_default) { build(:sell, :with_attributes) }
  let(:sell_one) { build(:sell, :with_attributes, :with_article) }
  let(:sell_two) { build(:sell, :with_attributes, :with_article, :with_more_quantity) }
  let(:sell_three) { build(:sell, :with_attributes, article: article_one) }
  let(:article_one) { build(:article, :with_attributes, :with_stock) }
  let(:article_two) { build(:article, :with_attributes, :with_stock, :with_second_price) }
  let(:article_three) { build(:article, :with_attributes, :with_stock, :with_third_price) }
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

    describe 'before create, the total revenue' do
      it 'should set automatically with the article one' do
        article_one.save
        sell_default.article_id = article_one.id

        expect(sell_default).to be_valid
        sell_default.save
        expect(sell_default.total_revenue).to be_present
        expect(sell_default.total_revenue).to be_eql(1198.98)
      end

      it 'should set automatically with the article two' do
        article_two.save
        sell_default.article_id = article_two.id

        expect(sell_default).to be_valid
        sell_default.save
        expect(sell_default.total_revenue).to be_present
        expect(sell_default.total_revenue).to be_eql(10_572.93)
      end

      it 'should set automatically with the article three' do
        article_three.save
        sell_default.article_id = article_three.id

        expect(sell_default).to be_valid
        sell_default.save
        expect(sell_default.total_revenue).to be_present
        expect(sell_default.total_revenue).to be_eql(3_820.98)
      end
    end

    describe 'before update, the total revenue' do
      it 'should updated automatically the sell with article one' do
        article_one.save
        sell_default.article_id = article_one.id
        sell_default.save

        expect(sell_default.total_revenue).to be_eql(1198.98)

        sell_default.update(quantity: 8)

        expect(sell_default.total_revenue).to_not be_eql(1198.98)
        expect(sell_default.total_revenue).to be_eql(3_197.28)
      end

      it 'should updated automatically the sell with article two' do
        article_two.save
        sell_default.article_id = article_two.id
        sell_default.save

        expect(sell_default.total_revenue).to be_eql(10_572.93)

        sell_default.update(quantity: 8)

        expect(sell_default.total_revenue).to_not be_eql(10_572.93)
        expect(sell_default.total_revenue).to be_eql(28_194.48)
      end

      it 'should updated automatically the sell with article three' do
        article_three.save
        sell_default.article_id = article_three.id
        sell_default.save

        expect(sell_default.total_revenue).to_not be_eql(1198.98)

        sell_default.update(quantity: 8)

        expect(sell_default.total_revenue).to_not be_eql(3_820.98)
        expect(sell_default.total_revenue).to be_eql(10_189.28)
      end
    end
  end
end
