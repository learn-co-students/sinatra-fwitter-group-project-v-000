user = User.create(username: 'skittles123', email: 'skittles@aol.com', password: 'rainbows')
user.save
Tweet.create(content: 'i am a boss at tweeting', user_id: user.id)
Tweet.create(content: 'tweeting!', user_id: user.id)
Tweet.create(content: 'tweet tweet tweet', user_id: user.id)

user = User.create(username: 'becky567', email: 'starz@aol.com', password: 'kittens')
user.save
Tweet.create(content: 'tweeting!', user_id: user.id)
Tweet.create(content: 'tweeting!!!', user_id: user.id)

user = User.create(username: 'silverstallion', email: 'silver@aol.com', password: 'horses')
user.save
Tweet.create(content: 'look at this tweet', user_id: user.id)
