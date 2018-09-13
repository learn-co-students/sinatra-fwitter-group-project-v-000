20.times do
    User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::NewGirl.character)
end

100.times do
  rando_user_id = rand(1..20)
  Tweet.create(content: Faker::ChuckNorris.fact, user_id: rando_user_id)
end
