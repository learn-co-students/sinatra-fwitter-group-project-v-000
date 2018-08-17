micah = User.create(name: "Micah", username: "micahshute", password: "password")
kristina = User.create(name: "Kristina", username: "ksshute", password: "password")
tony = User.create(name: "Tony", username: "tstark", password: "iamironman")
tweet1 = Tweet.create(content: "I love Kristina")
tweet1.user = micah
tweet1.save
tweet2 = Tweet.create(content: "I'm a dentist")
tweet2.user = kristina
tweet3 = Tweet.create(content: "idk who Ironman is but he's pretty cool.")
tweet3.user = tony
tweet3.user_likes << micah
tweet3.save
