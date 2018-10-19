sophie = User.create(username: "Sophie")
Tweet.create(content: "I love Fwitter", user: sophie, user.id => 10)
Tweet.create(content: "Party time!", user: sophie, user.id => 10)