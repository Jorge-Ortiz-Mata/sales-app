class AddSellsCountToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :sells_count, :integer, default: 0
  end
end
