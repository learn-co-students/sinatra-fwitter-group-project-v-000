User.create(username: "test01", password: "12345", email: "test1@test.com")
User.create(username: "test02", password: "12345", email: "test2@test.com")
User.create(username: "test03", password: "12345", email: "test3@test.com")
User.create(username: "test04", password: "12345", email: "test4@test.com")

tweets_list = {
    1 => {
        :content => "I love coding!"
    },
    2 => {
        :content => "I know, right?"
    },
    3 => {
        :content => "Have you done your Hacktober pushes yet?"
    },
    4 => {
        :content => "nope, missed it :("
    }
}

tweets_list.each do |user, hash|
    t = Tweet.new
    t.user_id = user
    hash.each do |attribute, value|
        t[attribute] = value
    end
    t.save
end