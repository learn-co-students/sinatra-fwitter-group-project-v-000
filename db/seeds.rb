      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      tweet1 = Tweet.create(:content => "tweeting!", :user_id => user.id)
      tweet2 = Tweet.create(:content => "tweet tweet tweet", :user_id => user.id)

      chaia = User.create(:username => "chaia ", :email => "chaia@aol.com", :password => "12345678")
      chaia1 = Tweet.create(:content => "tweeting hi!", :user_id => user.id)
      chaia2 = Tweet.create(:content => "i am ....", :user_id => user.id)