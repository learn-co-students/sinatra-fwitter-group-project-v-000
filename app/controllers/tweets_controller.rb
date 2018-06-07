class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
 end

     get '/tweets' do
       @tweets = Tweet.all
       erb :'/tweets'

     end


end
