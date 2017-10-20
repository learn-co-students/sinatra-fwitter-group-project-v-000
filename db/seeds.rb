@tweet = Tweet.create(content: "I love Smalls!")
@user = @tweet.create_user(username: "TheDude", email: "jknelson@lamecompany.com", password: "smallsisthebest")

new_tweet = @user.tweets.build({content: "Smalls is my favorite person"})

user2 = User.create(username: "JnelSmalls", email: "jnelsmalls@gmail.com", password: "coffeecup")
user2_tweets = user2.tweets.create([
  {content: "Sitting at @Startbucks on Wednesday afternoon"}, {content: "Larges's head is blocking everything in front of me."}
  ])
