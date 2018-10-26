class TweetsController < ApplicationController

get '/tweets' do
  
end

get "/tweets/new" do


erb :"/tweets/new"
end

post "/tweets" do
  @tweets = Tweet.all


  erb :'/tweets/:id'
end


end
