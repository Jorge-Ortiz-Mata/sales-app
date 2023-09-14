# Sells

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

for i in 1...100 do
  id = rand(Article.first.id..Article.all.count)
  day = rand(0...7)

  article = Article.find(id)

  if article && article.in_stock > 0
    Sell.create(
      article: article,
      quantity: rand(1..article.in_stock),
      date_of_sell: time_rand(Time.local(2023, 8, 8))
    )
  end
end
