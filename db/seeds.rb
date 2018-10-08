user1 = User.create(:username => 'nateshuster', :email => 'nate@testemail.com', :password => 'natenate')
user2 = User.create(:username => 'bmclain6', :email => 'mclain@testemail.com', :password => 'brianbrian')
user3 = User.create(:username => 'slimjimmy', :email => 'jimmy@testemail.com', :password => 'kaszkasz')
user4 = User.create(:username => 'bigwilly', :email => 'willy@testemail.com', :password => 'billbill')

tweet1 = Tweet.create(:content => 'here is test content for tweet1', :user_id => 1)
tweet2 = Tweet.create(:content => 'here is test content for tweet2', :user_id => 2)
tweet3 = Tweet.create(:content => 'here is test content for tweet3', :user_id => 3)
tweet4 = Tweet.create(:content => 'here is test content for tweet4', :user_id => 4)