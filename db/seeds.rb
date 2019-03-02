# Seed Date goes here

# 2 users
howard = User.create(username: "Howard", email: "howard@howard.com", password: "password")
malcome = User.create(username: "Malcome", email: "malcome@malcome.com", password: "password")

# A F-tweet

Tweet.create(content: "Today is Friday and it was snowing :(", user_id: malcome.id)

# Use AR to per-associate data:

malcome.tweets.create(content: "I am building a Sinatra app! Yaay! Boi!")

howards_entry = howard.tweets.build(content: "AMA I love questions! Questions make these
  sessions great!")
howards_entry.save
