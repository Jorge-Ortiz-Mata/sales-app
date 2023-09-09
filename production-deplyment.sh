# Prepare DB. If the database exists, it runs the migrations. Otherwise, it creates the database and run the migrations
rails db:prepare

# Launch Rails Server
puma
