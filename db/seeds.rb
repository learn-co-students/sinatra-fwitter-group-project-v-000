@brie = User.create(username: "brie", email: "brie@brie.com", password: "stephenrocks")

@stephen = User.create(username: "stephen", email: "stephen@brie.com", password: "brierocks")

Tweet.create(content: "Fwitter is great", user_id: @brie.id)
Tweet.create(content: "Indeed Fwitter is great!", user_id: @brie.id)
Tweet.create(content: "I agree", user_id: @stephen.id)
Tweet.create(content: "How cool is this?", user_id: @stephen.id)
Tweet.create(content: "I mean mega cool", user_id: @stephen.id)
