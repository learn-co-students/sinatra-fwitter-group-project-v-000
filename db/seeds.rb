#this is a seed file for my database. Seed with 'rake db:seed'
dj = User.create(username: "Donald Trump", password: "abc123", email: "TheDonald@gmail.com")
dj.tweets << Tweet.create(content: "Wow, I have such small hands, you wouldn't believe! Gonna make jobs great again folks.")
dj.tweets << Tweet.create(content: "Main stream media are BIGLY bullies for making fun of my spelling on twitter! Sad!")
dj.save

jrogan = User.create(username: "JoeRogan2", password: "abc123", email: "JREpowerful@gmail.com")
jrogan.tweets << Tweet.create(content: "Woah, did you guys see that bear? Absolutely insane primal instincts.")
jrogan.tweets << Tweet.create(content: "Jamie pull up chem trails on the screen. These guys are nuts, who actually believes this?")
jrogan.save
