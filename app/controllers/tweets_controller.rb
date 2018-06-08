class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
 end

     get '/tweets' do
       @tweets = Tweet.all
       erb :'/tweets/tweets'   #No such file or directory @ rb_sysopen - app/views/tweets.erb 

     end


end
