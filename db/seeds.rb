#Users 
user_1 = User.create(username: "thedude", email: 'lebowski@dude.com', password: "bowling4life")
user_2 = User.create(username: "therealprincessleia", email: 'herroyalhighness@alderaan.com', password: "hair_buns")
user_3 = User.create(username: "IndigoM", email: '6fingeredman@revenge.com', password: "PreparetoDie!")
user_4 = User.create(username: "notabot", email: '7838uajmdkkans0osd89@hmmm.com', password: "captcha_who?")

#Tweets

##user_1 
Tweet.create(content: "I’m the Dude, so that’s what you call me. That or, uh His Dudeness, or uh Duder, or El Duderino, if you’re not into the whole brevity thing.", user_id: user_1.id)
Tweet.create(content: "This aggression will not stand, man.", user_id: user_1.id)

##user_2
Tweet.create(content: "Help me @obi-wan_kenobi, you're my only hope.", user_id: user_2.id)
Tweet.create(content: ".@HanSolo is a stuck-up, half-witted, scruffy-looking Nerfherder!", user_id: user_2.id)

##user_3
Tweet.create(content: "Hello, you killed my father. Prepare to die.", user_id: user_3.id)
Tweet.create(content: ".@smarter_than_socrates keeps using that word. I do not think it means what he thinks it means.", user_id: user_3.id)

##user_4 
Tweet.create(content: "Super Mario president: God, not Supreme Court, has 'final authority'", user_id: user_4.id)
Tweet.create(content: "John Cena's efforts to build a Trump Tower in Moscow went on longer than he has previously acknowledged", user_id: user_4.id)
