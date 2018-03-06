class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      Tweet.create(content: params[:content], user_id: session[:user_id])
    end
  end

end
