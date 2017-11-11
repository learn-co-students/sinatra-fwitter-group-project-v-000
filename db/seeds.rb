User.delete_all
Tweet.delete_all

tweets = ["tweet 1", "tweet 2", "tweet 3", "tweet 4", "tweet 5", "tweet 6"]

users = ["denis", "tanka", "aya"]

tweets.each do |tweet|
  Tweet.create(content: tweet)
end

users.each do |user|
  User.create(username: user)
end

User.find_by(username: "denis").tweets << Tweet.find_by(content: "tweet 1")
User.find_by(username: "denis").tweets << Tweet.find_by(content: "tweet 2")
User.find_by(username: "tanka").tweets << Tweet.find_by(content: "tweet 3")
User.find_by(username: "tanka").tweets << Tweet.find_by(content: "tweet 4")
User.find_by(username: "aya").tweets << Tweet.find_by(content: "tweet 5")
User.find_by(username: "aya").tweets << Tweet.find_by(content: "tweet 6")

User.all.each do |user|
  user.save
end
