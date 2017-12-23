user1 = User.create(username:"kpeck71",email: "kpeck71@email.com", password:"1234")
user2 = User.create(username:"dansmith",email: "dsmith@email.com", password:"4321")

tweet = Tweet.create(content:"Hello World")
tweet.user = user1
tweet.save
