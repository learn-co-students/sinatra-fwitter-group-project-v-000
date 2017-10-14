MODELS

User
  -Username
  -Password
  -Tweets

has_many :tweets

Tweet
  -Content

belongs_to :user
