user1 = User.create(username: "user_1", email: "test1", password: "test1")
user2 = User.create(username: "user_2", email: "test2", password: "test2")

Tweet.create(user_id: user1.id, content: "hellllllo world!")
Tweet.create(user_id: user2.id, content: "living for the weekend!")
Tweet.create(user_id: user2.id, content: "beautiful day today")
Tweet.create(user_id: user1.id, content: "the suns shining!")
