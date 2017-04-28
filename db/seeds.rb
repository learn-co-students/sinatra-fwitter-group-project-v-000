User.create(
  :username => "skittles123",
  :email => "skittles@aol.com",
  :password => "rainbows"
  )

User.create(
	:username => "becky567",
	:email => "starz@aol.com",
	:password => "kittens"
	)

Tweet.create(
	content: "tweet1 by skittles[1]",
	user_id: 1
	)

Tweet.create(
	content: "tweet1 by becky[2]",
	user_id: 2
	)

Tweet.create(
	content: "tweet2 by skittles[1]",
	user_id: 1
	)

Tweet.create(
	content: "tweet2 by becky[2]",
	user_id: 2
	)

Tweet.create(
	content: "tweet3 by becky[2]",
	user_id: 2
	)