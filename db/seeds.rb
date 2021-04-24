user = User.create(:username => "billionsofbricks", :email => "billionsofbricks@gmail.com", :password => "password")
Tweet.create(:content => "Billions of Bricks is great.", :user_id => user.id)
Tweet.create(:content => "Lego is a great building element.", :user_id => user.id)

user1 = User.create(:username => "gerdpoint", :email => "gerdpoint@gmail.com", :password => "password")
Tweet.create(:content => "RC is great.", :user_id => user1.id)
Tweet.create(:content => "RC is a great hobby.", :user_id => user1.id)

user2 = User.create(:username => "crystalwengerphotography", :email => "crystalwengerphotography@gmail.com", :password => "password")
Tweet.create(:content => "Photography is great.", :user_id => user2.id)
Tweet.create(:content => "Photography is a great profession.", :user_id => user2.id)
