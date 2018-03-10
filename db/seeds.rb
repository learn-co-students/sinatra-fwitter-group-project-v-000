pepper = User.create(username: "Pepper", email: "pepper@test.com", password: "123")
tweet = Tweet.create(content: "I love bacon!")
tweet.user = pepper
tweet.save

User.create(username: "Alex", email: "alex@test.com", password: "test")
