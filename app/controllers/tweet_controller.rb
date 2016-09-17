class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      @user = User.find_by_id(session[:session_id])
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      @user = User.find_by_id(session[:session_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    binding.pry
  end

  get '/tweets/:id' do
    erb :show
  end

end
