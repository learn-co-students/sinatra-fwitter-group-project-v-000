usernames_list = [
  {
    username: "koreankabob",
    email: "kevikim33@gmail.com",
    password: "jumpman23"
  },

  {
    username: "realskipbayless",
    email: "skip.bayless@fs1.com",
    password: "pacquiao"
  },

  {
    username: "andersoncooper",
    email: "andersoncooper@cnn.com",
    password: "breakingnews"
  }
]

usernames_list.each do |user_hash|
  User.create(user_hash)
end

tweets_list = [
  {
    content: "I'm writing a corny joke",
    user_id: 1
  },

  {
    content: "Yet again, Lebron comes up small.",
    user_id: 2
  },

  {
    content: "BREAKING: North Korea announces new cross-pacific missile.",
    user_id: 3
  }

]

tweets_list.each do |tweet_hash|
  Tweet.create(tweet_hash)
end
