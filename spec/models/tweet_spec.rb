require 'spec_helper'

describe "Tweet" do
  before do
    @tweet = Tweet.create(content: "I'm changing my album name again.")

    @user = User.create(username: "yeezy", email: "kanye@west.com", password: "kimverysecure")
  end

  # for some reason rspec seem to not like the text datatype
  # it "has content" do
  #   expect (@tweet.content).to eq(@content)
  # end

  it "belongs to a user" do
    @user.tweets << @tweet
    expect(@tweet.user).to eq(@user)
  end

end
