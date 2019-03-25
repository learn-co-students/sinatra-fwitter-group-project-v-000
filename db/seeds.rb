travis = User.create(username: "Travis", email: "travis@nomoreheroes.com", password: "touchdown")

Tweet.create(content: "I love being bipolar. It's awesome.", user_id: travis.id)


