admin = User.create(username:"admin", password:"admin", email: "admin@fwitter.com")
admin.tweets.create(content: "testing testing testing")
admin.tweets.create(content: "Now working on the Fwitter project")
admin.tweets.create(content: "I need a beer")
