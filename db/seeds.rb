users = [
  {
    id: 1,
    username: 'eric',
    email: 'eric@ericbaker.me',
    password: 'password'
  },
  {
    id: 2,
    username: 'ebaker',
    email: 'ebaker16@gmail.com',
    password: 'pass'
  }
]

users.each do |user|
  User.create(user)
end

tweets = [
  {
    id: 1,
    content: "My first tweet!",
    user_id: 1
  },
  {
    id: 2,
    content: "My second tweet!",
    user_id: 1
  },
  {
    id: 3,
    content: "The first of many.",
    user_id: 2
  }
]

tweets.each do |tweet|
  Tweet.create(tweet)
end