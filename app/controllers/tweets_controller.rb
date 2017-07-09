class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "Please log in to view the tweets."
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      flash[:message] = "Please log in to create tweets."
      redirect '/login'
    end
  end

  post '/tweets' do
    # binding.pry
    if !params[:content].empty?
      current_user.tweets.create(params)
      redirect '/tweets'
    else
      flash[:message] = "Cannot create empty tweet!!"
      redirect '/tweets/new'
    end
  end

end
