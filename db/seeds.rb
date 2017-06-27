user1args = {:email => "test1@test.com", :username => "test1", :password => "RockAndRoll"}
user2args = {:email => "test2@test.com", :username => "test2", :password => "Love2Code"}
tweet1args = {:content => "tweet test 1", :user_id => 1}
tweet2args = {:content => "tweet test 2", :user_id => 2}
User.create(user1args)
User.create(user2args)
Tweet.create(tweet1args)
Tweet.create(tweet2args)