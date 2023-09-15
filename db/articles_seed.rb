# ======== Food Articles ==========
food_category = Category.find_by(name: 'Comida')

for i in 0...5 do
  article = Article.create(name: Faker::Food.allergen, price: rand(100.0...2000.0).round(2), description: Faker::Food.description)

  article.categories << food_category
end

# ======== Computer Articles ==========
computer_category = Category.find_by(name: 'Computadoras')

for i in 0...5 do
  article = Article.create(name: Faker::Computer.stack, price: rand(100.0...2000.0).round(2), description: Faker::Computer.platform)

  article.categories << computer_category
end

# ======== Videogames Articles ==========
videogames_category = Category.find_by(name: 'Videojuegos')

for i in 0...5 do
  article = Article.create(name: Faker::Game.title, price: rand(100.0...2000.0).round(2), description: Faker::Game.platform)

  article.categories << videogames_category
end

# ======== Movies Articles ==========
movies_category = Category.find_by(name: 'Peliculas')

for i in 0...5 do
  article = Article.create(name: Faker::Movie.title, price: rand(100.0...2000.0).round(2), description: Faker::Movie.quote)

  article.categories << movies_category
end

# ======== Books Articles ==========
books_category = Category.find_by(name: 'Libros y novelas')

for i in 0...5 do
  article = Article.create(name: Faker::Book.title, price: rand(100.0...2000.0).round(2), description: Faker::Book.genre)

  article.categories << books_category
end

# ======== Furniture Articles ==========
furniture_category = Category.find_by(name: 'Muebles')

for i in 0...5 do
  article = Article.create(name: Faker::House.furniture, price: rand(100.0...2000.0).round(2), description: Faker::House.room)

  article.categories << furniture_category
end

# ======== Cars Articles ==========
cars_cateogry = Category.find_by(name: 'Autos')

for i in 0...5 do
  article = Article.create(name: Faker::Vehicle.make_and_model, price: rand(100.0...2000.0).round(2), description: Faker::Vehicle.drive_type + Faker::Vehicle.transmission + Faker::Vehicle.color)

  article.categories << cars_cateogry
end

# ======== Musica Articles ==========
music_category = Category.find_by(name: 'Musica')

for i in 0...5 do
  article = Article.create(name: Faker::Music.instrument,price: rand(100.0...2000.0).round(2),description: Faker::Music.album)

  article.categories << music_category
end
