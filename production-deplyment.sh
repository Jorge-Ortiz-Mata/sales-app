# Prepare DB. If the database exists, it runs the migrations. Otherwise, it creates the database and run the migrations
rails db:prepare

# Compile assets
rails assets:precompile

# Launch Rails Server
puma
