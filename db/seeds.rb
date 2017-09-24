user1 = User.create(:username=>"bob", :email => "bob@bob.com", :password => 'bob')
user2 = User.create(:username=>"bob1",:email => "bob@bob.com", :password => 'bob1')
user3 = User.create(:username=>"bob2",:email => "bob@bob.com", :password => 'bob2')

def randTweet
    (0...40).map { (65 + rand(26)).chr }.join
end

5.times do
    User.all.length.times do |i|
        Tweet.create(:user_id=>i+1,:content => randTweet)
    end
end