lucy = User.create(:username => "Lucy Ricardo", :email => "lucy@domain.com", :password => "test")
t1 = Tweet.create(:content => "I want to be in a show")
t2 = Tweet.create(:content => "I spend Ricky's money")
lucy.tweets << t1
lucy.tweets << t2
lucy.save
ethel = User.create(:username => "Ethel Mertz", :email => "ethel@domain.com", :password => "test")
t3 = Tweet.create(:content => "Fred is cheap")
t4 = Tweet.create(:content => "Lucy is my best friend")
ethel.tweets << t3
ethel.tweets << t4
ethel.save
