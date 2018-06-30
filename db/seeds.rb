user1 = User.create(username: "user1", email: "user1@gmail.com", password_digest: "password1")
user2 = User.create(username: "user2", email: "user2@gmail.com", password_digest: "password2")
user3 = User.create(username: "user3", email: "user3@gmail.com", password_digest: "password3")

Tweet.create(content: "Tweet 1 content goes here!", user_id: 1)
Tweet.create(content: "Tweet 2 content goes here!", user_id: 2)
Tweet.create(content: "Tweet 3 content goes here!", user_id: 3)
Tweet.create(content: "Tweet 4 content goes here!", user_id: 1)
Tweet.create(content: "Tweet 5 content goes here!", user_id: 3)

User.all.each {|u| u.save}
Tweet.all.each {|t| t.save}
