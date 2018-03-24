rob = User.create(username: 'Rob', password: '1234', email: 'rob@rob.com')
tweet1 = Tweet.create(content: 'Hihi')
tweet1.user = rob
tweet1.save
tweet2 = Tweet.create(content: 'Ruby ruby ruby')
tweet2.user = rob
tweet2.save

somwya = User.create(username: 'Som', password: 'letmein', email: 'hi@hi.com')
tweet3 = Tweet.create(content: 'Good morning')
tweet3.user = somwya
tweet3.save
tweet4 = Tweet.create(content: 'New website is available!')
tweet4.user = somwya
tweet4.save
