jam = User.create(username: "jamproxy", email: "jam7289@aol.com", password: "caicedo24")
eric = User.create(username: "e-rich", email: "ericr@msn.com", password: "gummybears")
chad = User.create(username: "chadder", email: "chad24@gmail.com", password: "farenheit451")

jam.tweets << Tweet.create(content: "jam's first tweet!")
jam.tweets << Tweet.create(content: "testing skittles")
jam.tweets << Tweet.create(content: "blah blah blah")

eric.tweets << Tweet.create(content: "silly duck")

chad.tweets << Tweet.create(content: "sup, chad")
chad.tweets << Tweet.create(content: "chad is smart")
