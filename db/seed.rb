grimm = User.new(user_name: "grimm")
grimm.email = "grimm@gmail.com"
grimm.password_digest = "grimm"
grimm.save

grimmtweet = Tweet.new(content: "grimmtweet")
grimm.save

User.create(user_name: "tom", email: "tom@gmail.com", password_digest: "tom")

Tweet.create(content: "tomtweet")
