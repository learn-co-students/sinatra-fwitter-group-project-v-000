class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
 end

     get '/tweets' do
         @users = User.all
         @tweets = Tweet.all
    erb :'/tweets/show_tweet'

     end

      get '/tweets/new' do

          @tweets = Tweet.all
          @users = User.all

      erb :'/tweets/create_tweet'

      end


      # post '/tweets' do
      #
      #   erb : '/tweets'
      # end


end
