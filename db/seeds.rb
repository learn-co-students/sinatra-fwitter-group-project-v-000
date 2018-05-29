lucy = User.create(:username => "Lucy Ricardo", :email => "lucy@domain.com", :password => "test")
t1 = Tweet.create(:content => "I want to be in a show")
t2 = Tweet.create(:content => "I spend Ricky's money")
lucy.tweets << t1
lucy.tweets << t2
lucy.save
