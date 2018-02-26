user1 = User.create(username: "saurookadook", email: "maskiella@gmail.com", password: "ilovecatz")

tweet1 = Tweet.create(content: "First tweet!", user_id: user1.id)
