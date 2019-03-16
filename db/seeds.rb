users_list = {
  "Cat" => {email: "cat@cat.com", password: "cat"},
  "Dog" => {:email => "dog@dog.com", :password => "dog"},
  "Bird" => {:email => "bird@bird.com", :password => "bird"}
}

users_list.each do |name, hash|
  u = User.new
  u.username = name
  u.email = hash[:email]
  u.password = hash[:password]
  u.save
end

tweets_list = {
  "meow" => {:user_id => 1},
  "woof" => {:user_id => 2},
  "sqwak" => {:user_id => 3}
}

tweets_list.each do |content, hash|
  t = Tweet.new
  t.content = content
  t.user_id = hash[:user_id]
  t.save
end
