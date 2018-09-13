# first_user = User.new
# first_user.name = "Grant"
#
# first_tweet = Tweet.new
# first_tweet.content = "my first tweet"




users_list = {
    "Madison" => { "madison@gmail.com" => {
      :password => 1
    },
    "Grant" => { "grant@gmail.com" => {
      :password => 2
      }
    }
  }

users_list.each do |name, email, password_hash|
  p = Landmark.new
  p.name = name
  password_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
