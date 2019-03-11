#Will create seed data to work with and test associations

#Create 2 users

kristin = User.create(username: "Kristin", email: "kristin@kristin.com", password: "password")
grant = User.create(username: "Grant", email: "Grant@grant.com", password: "password")

#create some tweets

Tweet.create(content: "This is my first tweet, this is awesome", user_id: kristin.id)

#Us AR to pre-associate data:

kristin.tweets.create(content: "I am building a Sinatra app!")

grants_entry = grant.tweets.build(content: "I love fortnite!")
grants_entry.save
