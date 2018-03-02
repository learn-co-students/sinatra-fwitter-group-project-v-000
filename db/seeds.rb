user = User.create(username:"Allyson", email: "allyson@aol.com", password: "kittens")
user.tweets.build(content:"A tweet")
user.save
