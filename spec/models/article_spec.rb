require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article_one) { build(:article, :with_attributes, :with_stock) }
  let(:article_two) { build(:article, :with_attributes, :without_stock, name: 'Iphone 14', price: 799.99) }
  let(:article_three) { build(:article, :with_attributes, :with_stock, name: 'Iphone 15', price: 599.99) }
  let(:category_one) { build(:category, :with_attributes) }
  let(:invalid_article) { build(:article) }

  describe 'instances' do
    it 'should be a valid instance' do
      expect(article_one).to be_valid
    end

    it 'should not be a valid instance' do
      expect(invalid_article).to be_invalid
    end
  end

  describe 'scopes' do
    before do
      article_one.save
      article_two.save
      article_three.save
      @articles = Article.all
    end

    it 'should return the articles with a min price specified' do
      expect(@articles.count).to be_eql(3)
      expect(Article.with_min_price(@articles, 500.00).count).to be_eql(2)
      expect(Article.with_min_price(@articles, 700.00).count).to be_eql(1)
    end

    it 'should return the articles with a max price specified' do
      expect(@articles.count).to be_eql(3)
      expect(Article.with_max_price(@articles, 600.00).count).to be_eql(2)
      expect(Article.with_max_price(@articles, 400.00).count).to be_eql(1)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'attachments' do
    it { should have_one_attached(:avatar) }
    it { should have_one_attached(:promotional_video) }
    it { should have_many_attached(:images) }
  end

  describe 'rich text' do
    it { should have_rich_text(:description) }
  end

  describe 'associations' do
    it { should have_many(:sells) }
    it { should have_and_belong_to_many(:categories) }
  end

  describe 'set categories' do
    it 'should associate categories' do
      article_one.save
      category_one.save

      expect(article_one.categories.count).to be_eql(0)

      article_one.categories << category_one

      expect(article_one.categories.count).to be_eql(1)
    end
  end
end
