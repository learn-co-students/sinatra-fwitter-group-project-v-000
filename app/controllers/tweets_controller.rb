class TweetsController < ApplicationController

   get '/tweets' do
  #  binding.pry
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
       redirect '/login'
    end
    
  end

  get '/logout' do
    # binding.pry
    if logged_in?
      session.clear
      redirect 'login' 
    else
     redirect '/'
    end
  end

  get '/tweets/new' do
    @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/create_tweet'
  end

  post '/tweets/new' do
# binding.pry
    @constant = params[:content]
  end
end