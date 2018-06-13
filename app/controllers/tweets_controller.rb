class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
 end

      get '/tweets' do

        if logged_in?

           @users = User.all
           @tweets = Tweet.all
           erb :'/tweets/show_tweet'
         else
           redirect to "/login"
         end

      end




      get '/tweets/new' do
          @tweets = Tweet.all
          @users = User.all
      erb :'/tweets/create_tweet'

      end


end
