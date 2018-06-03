require 'spec_helper'

describe 'Tweet' do 
  
  before do 
    @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
    @fweet_1 = Tweet.create(:content => "Twitter is overrated.", :user_id => @user.id)
    @fweet_2 = Tweet.create(:content => "I want to take a nap", :user_id => @user.id)
    Tweet.create(:content => "", :user_id => @user.id)
  end
  
  it "initializes with content and a user_id" do 
    expect(@fweet_1.content).to eq("Twitter is overrated.")
    expect(@fweet_2.user_id).to be_truthy 
  end 
  
  it 'cannot initialize without content or a user_id' do 
    expect{Tweet.create(:user_id => 2)}.to raise_error{ |error| expect(error).to be_a(ActiveRecord::StatementInvalid) }
    
    expect{Tweet.create(:content => "FAIL")}.to raise_error{ |error| expect(error).to be_a(ActiveRecord::StatementInvalid) }
  end 
  
  it 'belongs to a user' do 
    expect(@fweet_1.user).to eq(@user)
  end 
  
  it 'content can be edited' do 
    new_content = "Twitter is overrated, but Fwitter's pretty cool"
    @fweet_1.content = new_content
    
    expect(@fweet_1.content).to eq(new_content)
  end
  
  it 'can be deleted from db' do 
    Tweet.find(@fweet_2.id).destroy
    
    expect{Tweet.find(@fweet_2.id)}.to raise_error{ |error| expect(error).to be_a(ActiveRecord::RecordNotFound) }
  end 
  
end 
  