class TweetsController < ApplicationController

  get '/tweets' do
  #  binding.pry
    if logged_in?
      puts "This is process #{Process.pid}"
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


end