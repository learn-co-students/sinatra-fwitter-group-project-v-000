user = User.create(username: "User", email: "user@gmail.com", password: "pass")
user2 = User.create(username: "User2", email: "user2@gmail.com", password: "pass")

tweet = Tweet.create(content: "This is a tweet")
tweet2 = Tweet.create(content: "This is another tweet")

tweet.user = user
tweet.save

tweet2.user = user2
tweet2.save
