user1 = User.create({:username => "aljim", :email => "test@gmail.com", :password => "password"})

tweet1 = Tweet.create({:content => "I like pizza"})

user1.tweets << tweet1
