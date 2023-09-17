default_users = ['ortiz.mata.jorge@gmail.com']

default_users.each do |email|
  next if User.find_by(email: email).present?

  User.create(email: 'ortiz.mata.jorge@gmail.com', password: '12345678', password_confirmation: '12345678')
end
