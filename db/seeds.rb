user1 = User.create(:username => "zayn", :email => "zayn@malik.com", :password => "pillowtalk")

user2 = User.create(:username => "flatiron4lyfe", :email => "code@journey.edu", :password => "Rubie!")

user3 = User.create(:username => "tina", :email => "tina@fey.com", :password => "thirtyrock")

user1.tweets << Tweet.create(content: "I am no longer a member of the Power Rangers.")

user2.tweets << Tweet.create(content: "I am about this life!")

user3.tweets << Tweet.create(content: "I am really, really hilarious.")