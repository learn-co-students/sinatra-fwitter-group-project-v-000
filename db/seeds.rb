user1 = User.create(username: "John", email: "test123@hotmail.com" )
user2 = User.create(username: "Frank", email: "321test@hotmail.com")

tweet1 = Tweet.create(content: "This is a tweet, yo")
tweet2 = Tweet.create(content: "This is a tweet different, yo!")

user1.tweets << tweet1
user2.tweets << tweet2