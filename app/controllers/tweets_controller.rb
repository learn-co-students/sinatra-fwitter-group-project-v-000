class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
 end

     get '/tweets' do
       @tweets = Tweet.all
       erb :index

     end


end
