class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/tweets'  
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
  
    if logged_in? && (params[:content] != "")
      user = User.find_by(session[:user_id])
      tweet = Tweet.new(content: params[:content])
      tweet.user_id = user.id
      tweet.save

      redirect to "/tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

end
